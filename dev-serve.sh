#!/bin/bash
# Script to start a Jekyll server with live reload and data file monitoring.
# Cross-platform: Linux, macOS, Windows (Git Bash/WSL)
# Overcomes the limitations of Jekyll's incremental mode by monitoring data files and triggering rebuilds.

# Colors for pretty output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Detect OS
detect_os() {
  case "$(uname -s)" in
    Linux*)   OS="linux" ;;
    Darwin*)  OS="macos" ;;
    CYGWIN*|MINGW*|MSYS*) OS="windows" ;;
    *)        OS="unknown" ;;
  esac
  echo -e "${BLUE}Detected OS: ${OS}${NC}"
}

# Initialize Ruby environment (rbenv)
init_ruby_env() {
  if command -v rbenv &> /dev/null; then
    eval "$(rbenv init - zsh 2>/dev/null || rbenv init - bash 2>/dev/null || true)"
  fi
}

# Initialize Node environment (fnm)
init_node_env() {
  if command -v fnm &> /dev/null; then
    eval "$(fnm env --use-on-cd 2>/dev/null || true)"
  fi
}

# Initialize environments
init_ruby_env
init_node_env

echo -e "${YELLOW}Jekyll Hot-Reload Development Server${NC}"
echo -e "${BLUE}This script will rebuild the site with data changes and provide live-reload.${NC}"

# Touch a file to trigger Jekyll rebuild
trigger_rebuild() {
  echo -e "${YELLOW}Data file change detected! Triggering rebuild...${NC}"
  if [[ "$OS" == "windows" ]]; then
    # Windows compatible touch
    INDEX_FILE=$(find . -name "index.*" | head -n 1)
    if [[ -n "$INDEX_FILE" ]]; then
      cat "$INDEX_FILE" > "$INDEX_FILE.tmp" && mv "$INDEX_FILE.tmp" "$INDEX_FILE"
    fi
  else
    find . -name "index.*" | head -n 1 | xargs touch
  fi
}

# Watch for changes in data files - cross-platform
watch_data_files() {
  echo -e "${BLUE}Starting data file watcher...${NC}"
  
  (
    if [[ "$OS" == "macos" ]] && command -v fswatch &> /dev/null; then
      # macOS with fswatch
      fswatch -0 -r _data 2>/dev/null | while read -d "" event; do
        trigger_rebuild
        sleep 1
      done
    elif [[ "$OS" == "linux" ]] && command -v inotifywait &> /dev/null; then
      # Linux with inotifywait
      while true; do
        inotifywait -r -e modify,create,delete _data > /dev/null 2>&1
        trigger_rebuild
        sleep 1
      done
    elif command -v fswatch &> /dev/null; then
      # Fallback to fswatch if available
      fswatch -0 -r _data 2>/dev/null | while read -d "" event; do
        trigger_rebuild
        sleep 1
      done
    elif command -v inotifywait &> /dev/null; then
      # Fallback to inotifywait if available
      while true; do
        inotifywait -r -e modify,create,delete _data > /dev/null 2>&1
        trigger_rebuild
        sleep 1
      done
    else
      # Polling fallback for Windows or when no watcher is available
      echo -e "${YELLOW}No file watcher found. Using polling (checks every 2s)...${NC}"
      LAST_HASH=""
      while true; do
        if [[ "$OS" == "windows" ]]; then
          CURRENT_HASH=$(find _data -type f -exec stat -c "%Y %n" {} \; 2>/dev/null | sort | md5sum 2>/dev/null || echo "")
        else
          CURRENT_HASH=$(find _data -type f -exec stat -f "%m %N" {} \; 2>/dev/null | sort | md5 2>/dev/null || \
                         find _data -type f -exec stat -c "%Y %n" {} \; 2>/dev/null | sort | md5sum 2>/dev/null || echo "")
        fi
        if [[ -n "$LAST_HASH" && "$CURRENT_HASH" != "$LAST_HASH" ]]; then
          trigger_rebuild
        fi
        LAST_HASH="$CURRENT_HASH"
        sleep 2
      done
    fi
  ) &
  
  WATCHER_PID=$!
  echo "Data watcher started with PID: $WATCHER_PID"
}

# Prepare site for a full rebuild
clean_and_rebuild() {
  echo -e "${YELLOW}Preparing for full rebuild...${NC}"
  
  # Clean _site directory
  if [ -d "_site" ]; then
    echo -e "${BLUE}Removing _site directory...${NC}"
    rm -rf _site
  fi
  
  # Build static assets with npm (if needed)
  if [ "$1" = "with-assets" ]; then
    echo -e "${BLUE}Rebuilding static assets with npm...${NC}"
    npm run build
  fi
  
  echo -e "${GREEN}Site prepared for rebuild!${NC}"
}

# Cleanup function to kill all background processes when exiting
cleanup() {
  echo -e "${YELLOW}Cleaning up...${NC}"
  
  # Kill data watcher if it exists
  if [ -n "$WATCHER_PID" ]; then
    echo -e "${BLUE}Stopping data file watcher (PID: $WATCHER_PID)...${NC}"
    kill $WATCHER_PID > /dev/null 2>&1
    # Also kill any child processes
    pkill -P $WATCHER_PID > /dev/null 2>&1 || true
  fi
  
  echo -e "${GREEN}Cleanup done. Goodbye!${NC}"
  exit 0
}

# Install file watcher if missing
install_watcher() {
  if [[ "$OS" == "macos" ]]; then
    if ! command -v fswatch &> /dev/null; then
      echo -e "${YELLOW}fswatch not found. Install with: brew install fswatch${NC}"
      return 1
    fi
  elif [[ "$OS" == "linux" ]]; then
    if ! command -v inotifywait &> /dev/null; then
      echo -e "${YELLOW}inotifywait not found. Install with: sudo apt-get install inotify-tools${NC}"
      return 1
    fi
  fi
  return 0
}

# Main process
main() {
  # Detect OS first
  detect_os
  
  # Check for file watcher (non-fatal, will use polling fallback)
  install_watcher || echo -e "${BLUE}Will use polling fallback for file watching.${NC}"

  # Make sure npm dependencies are installed
  if [ ! -d "node_modules" ]; then
    echo -e "${YELLOW}Installing npm dependencies...${NC}"
    npm install
  fi
  
  # Make sure bundle dependencies are installed
  if [ ! -f "Gemfile.lock" ]; then
    echo -e "${YELLOW}Installing Ruby dependencies...${NC}"
    bundle install
  fi
  
  # Clean and prepare for first build
  clean_and_rebuild "with-assets"
  
  # Set up the cleanup function to run when the script exits
  trap cleanup EXIT INT TERM
  
  # Start data file watcher
  watch_data_files
  
  # Start Jekyll server
  echo -e "${GREEN}Starting Jekyll server with live reload...${NC}"
  echo -e "${BLUE}Access your site at${NC} ${GREEN}http://localhost:4000${NC}"
  echo -e "${YELLOW}Press Ctrl+C to stop the server${NC}"
  
  # Run Jekyll build first to generate site, then start the server
  echo -e "${BLUE}Building site...${NC}"
  bundle exec jekyll build
  
  # Then start the server with livereload and incremental builds
  echo -e "${GREEN}Starting live server...${NC}"
  echo -e "${YELLOW}NOTE: Data file changes will trigger a full page reload${NC}"
  
  # Use incremental mode for faster rebuilds on file changes
  bundle exec jekyll serve --livereload --incremental
}

# Execute the main process
main "$@"
