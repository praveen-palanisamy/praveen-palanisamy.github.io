#!/bin/bash
# Setup script for Jekyll GitHub Pages development environment
# Target: arm64 macOS with Homebrew

set -e

# Colors for pretty output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${YELLOW}=====================================${NC}"
echo -e "${YELLOW}Jekyll Dev Environment Setup Script${NC}"
echo -e "${YELLOW}=====================================${NC}"
echo ""

# Get script directory (where the project lives)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Detect shell profile based on current shell
get_shell_profile() {
  local current_shell
  current_shell=$(basename "${SHELL:-/bin/bash}")
  
  case "$current_shell" in
    zsh)
      if [[ -f ~/.zshrc ]]; then
        echo ~/.zshrc
      else
        echo ~/.zprofile
      fi
      ;;
    bash)
      if [[ -f ~/.bashrc ]]; then
        echo ~/.bashrc
      elif [[ -f ~/.bash_profile ]]; then
        echo ~/.bash_profile
      else
        echo ~/.profile
      fi
      ;;
    *)
      # Fallback to .profile for other shells
      echo ~/.profile
      ;;
  esac
}

# Check if running on macOS
if [[ "$(uname)" != "Darwin" ]]; then
  echo -e "${RED}Error: This script is designed for macOS${NC}"
  exit 1
fi

# Check architecture
ARCH=$(uname -m)
echo -e "${BLUE}Detected architecture: ${ARCH}${NC}"

# Check if Homebrew is installed
check_homebrew() {
  echo -e "${BLUE}Checking for Homebrew...${NC}"
  if ! command -v brew &> /dev/null; then
    echo -e "${YELLOW}Homebrew not found. Installing...${NC}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for arm64 Macs (idempotent check)
    if [[ "$ARCH" == "arm64" ]]; then
      if ! grep -q '/opt/homebrew/bin/brew shellenv' ~/.zprofile 2>/dev/null; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
      fi
      eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
  else
    echo -e "${GREEN}✓ Homebrew is installed${NC}"
  fi
}

# Install Ruby via rbenv for isolated environment
install_ruby() {
  echo -e "${BLUE}Setting up Ruby environment...${NC}"
  
  # Install rbenv and ruby-build if not present
  if ! command -v rbenv &> /dev/null; then
    echo -e "${YELLOW}Installing rbenv and ruby-build...${NC}"
    brew install rbenv ruby-build
  else
    echo -e "${GREEN}✓ rbenv is installed${NC}"
  fi
  
  # Initialize rbenv
  eval "$(rbenv init - zsh 2>/dev/null || rbenv init - bash 2>/dev/null || true)"
  
  # Add rbenv init to shell profile if not present (idempotent)
  SHELL_PROFILE=$(get_shell_profile)
  if [[ -n "$SHELL_PROFILE" ]] && ! grep -q 'rbenv init' "$SHELL_PROFILE" 2>/dev/null; then
    echo -e "${YELLOW}Adding rbenv init to $SHELL_PROFILE...${NC}"
    echo '' >> "$SHELL_PROFILE"
    echo '# rbenv initialization' >> "$SHELL_PROFILE"
    echo 'eval "$(rbenv init - zsh 2>/dev/null || rbenv init - bash 2>/dev/null || true)"' >> "$SHELL_PROFILE"
  else
    echo -e "${GREEN}✓ rbenv init already in $SHELL_PROFILE${NC}"
  fi
  
  # Determine Ruby version (use .ruby-version if exists, else use a stable version)
  if [[ -f .ruby-version ]]; then
    RUBY_VERSION=$(cat .ruby-version)
    echo -e "${BLUE}Using Ruby version from .ruby-version: ${RUBY_VERSION}${NC}"
  else
    # Use Ruby 3.1.x for GitHub Pages compatibility
    RUBY_VERSION="3.1.4"
    echo -e "${BLUE}Using Ruby version: ${RUBY_VERSION}${NC}"
    echo "$RUBY_VERSION" > .ruby-version
  fi
  
  # Check if the required Ruby version is installed
  if ! rbenv versions --bare | grep -q "^${RUBY_VERSION}$"; then
    echo -e "${YELLOW}Installing Ruby ${RUBY_VERSION}...${NC}"
    
    # Install build dependencies for Ruby
    brew install openssl@3 readline libyaml gmp
    
    # Set compiler flags for arm64
    export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@3)"
    
    rbenv install "$RUBY_VERSION"
  else
    echo -e "${GREEN}✓ Ruby ${RUBY_VERSION} is already installed${NC}"
  fi
  
  # Set local Ruby version for this project
  rbenv local "$RUBY_VERSION"
  rbenv rehash
  
  echo -e "${GREEN}✓ Ruby $(ruby --version) configured${NC}"
}

# Install Bundler
install_bundler() {
  echo -e "${BLUE}Setting up Bundler...${NC}"
  
  # Ensure we're using rbenv Ruby
  eval "$(rbenv init - zsh 2>/dev/null || rbenv init - bash 2>/dev/null || true)"
  
  if ! gem list bundler -i > /dev/null 2>&1; then
    echo -e "${YELLOW}Installing Bundler...${NC}"
    gem install bundler
    rbenv rehash
  else
    echo -e "${GREEN}✓ Bundler is already installed${NC}"
  fi
}

# Install Node.js via fnm for isolated environment
install_node() {
  echo -e "${BLUE}Setting up Node.js environment...${NC}"
  
  # Check if fnm is installed
  if ! command -v fnm &> /dev/null; then
    echo -e "${YELLOW}Installing fnm...${NC}"
    brew install fnm
  else
    echo -e "${GREEN}✓ fnm is installed${NC}"
  fi
  
  # Load fnm
  eval "$(fnm env --use-on-cd 2>/dev/null || true)"
  
  # Add fnm init to shell profile if not present (idempotent)
  SHELL_PROFILE=$(get_shell_profile)
  if [[ -n "$SHELL_PROFILE" ]] && ! grep -q 'fnm env' "$SHELL_PROFILE" 2>/dev/null; then
    echo -e "${YELLOW}Adding fnm init to $SHELL_PROFILE...${NC}"
    echo '' >> "$SHELL_PROFILE"
    echo '# fnm (Fast Node Manager) initialization' >> "$SHELL_PROFILE"
    echo 'eval "$(fnm env --use-on-cd)"' >> "$SHELL_PROFILE"
  else
    echo -e "${GREEN}✓ fnm init already in $SHELL_PROFILE${NC}"
  fi
  
  # Use .node-version or .nvmrc if exists, else use LTS
  local USE_LTS=false
  if [[ -f .node-version ]]; then
    NODE_VERSION=$(cat .node-version)
    echo -e "${BLUE}Using Node.js version from .node-version: ${NODE_VERSION}${NC}"
  elif [[ -f .nvmrc ]]; then
    NODE_VERSION=$(cat .nvmrc)
    echo -e "${BLUE}Using Node.js version from .nvmrc: ${NODE_VERSION}${NC}"
  else
    USE_LTS=true
    echo -e "${BLUE}Using Node.js LTS${NC}"
  fi
  
  # Install and use the Node version (idempotent - fnm handles already-installed versions)
  if [[ "$USE_LTS" == true ]]; then
    fnm install --lts
    fnm use lts-latest
  else
    fnm install "$NODE_VERSION"
    fnm use "$NODE_VERSION"
  fi
  
  echo -e "${GREEN}✓ Node.js $(node --version) configured${NC}"
}

# Install fswatch for macOS (replaces inotifywait)
install_fswatch() {
  echo -e "${BLUE}Setting up file watcher...${NC}"
  
  if ! command -v fswatch &> /dev/null; then
    echo -e "${YELLOW}Installing fswatch (macOS alternative to inotifywait)...${NC}"
    brew install fswatch
  else
    echo -e "${GREEN}✓ fswatch is installed${NC}"
  fi
}

# Install project dependencies
install_dependencies() {
  echo -e "${BLUE}Installing project dependencies...${NC}"
  
  # Ensure we're using rbenv Ruby
  eval "$(rbenv init - zsh 2>/dev/null || rbenv init - bash 2>/dev/null || true)"
  
  # Load fnm
  eval "$(fnm env --use-on-cd 2>/dev/null || true)"
  
  # Configure Bundler to install gems locally
  echo -e "${YELLOW}Configuring Bundler for local gem installation...${NC}"
  bundle config set --local path 'vendor/bundle'
  
  # Install Ruby gems
  echo -e "${YELLOW}Installing Ruby gems...${NC}"
  bundle install
  
  # Install npm packages
  echo -e "${YELLOW}Installing npm packages...${NC}"
  npm install
  
  echo -e "${GREEN}✓ All dependencies installed${NC}"
}

# Add entries to .gitignore
update_gitignore() {
  echo -e "${BLUE}Updating .gitignore...${NC}"
  
  ENTRIES=(
    "# Ruby/Bundler"
    "vendor/bundle/"
    ".bundle/"
    "Gemfile.lock"
    ""
    "# Node"
    "node_modules/"
    ""
    "# Jekyll"
    "_site/"
    ".jekyll-cache/"
    ".jekyll-metadata"
    ""
    "# Environment"
    ".ruby-version"
    ".node-version"
    ".nvmrc"
    ""
    "# Backup files"
    "*.bak"
  )
  
  if [[ ! -f .gitignore ]]; then
    touch .gitignore
  fi
  
  for entry in "${ENTRIES[@]}"; do
    if [[ -n "$entry" ]] && ! grep -qF "$entry" .gitignore 2>/dev/null; then
      echo "$entry" >> .gitignore
    fi
  done
  
  echo -e "${GREEN}✓ .gitignore updated${NC}"
}

# Print summary
print_summary() {
  echo ""
  echo -e "${GREEN}=====================================${NC}"
  echo -e "${GREEN}Setup Complete!${NC}"
  echo -e "${GREEN}=====================================${NC}"
  echo ""
  echo -e "${BLUE}Environment Summary:${NC}"
  echo -e "  Ruby:    $(ruby --version 2>/dev/null || echo 'reload shell')"
  echo -e "  Bundler: $(bundle --version 2>/dev/null || echo 'reload shell')"
  echo -e "  Node:    $(node --version 2>/dev/null || echo 'reload shell')"
  echo -e "  npm:     $(npm --version 2>/dev/null || echo 'reload shell')"
  echo ""
  echo -e "${YELLOW}To start developing:${NC}"
  echo -e "  1. Open a new terminal (to load environment)"
  echo -e "  2. cd $(pwd)"
  echo -e "  3. ./dev-serve.sh"
  echo ""
  echo -e "${BLUE}Your site will be available at:${NC} ${GREEN}http://localhost:4000${NC}"
  echo ""
}

# Main execution
main() {
  check_homebrew
  install_ruby
  install_bundler
  install_node
  install_fswatch
  update_gitignore
  install_dependencies
  print_summary
}

main "$@"
