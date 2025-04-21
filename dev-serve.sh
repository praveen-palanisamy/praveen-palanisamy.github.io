#!/bin/bash
# Script to start a Jekyll server with live reload and data file monitoring. Overcomes the limitations of Jekyll's incremental mode by monitoring data files and triggering rebuilds.

# Colors for pretty output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Jekyll Hot-Reload Development Server${NC}"
echo -e "${BLUE}This script will rebuild the site with data changes and provide live-reload.${NC}"

# Watch for changes in data files
watch_data_files() {
  echo -e "${BLUE}Starting data file watcher...${NC}"
  
  # Run in background
  (
    while true; do
      # Watch for changes in data files
      inotifywait -r -e modify,create,delete _data > /dev/null 2>&1
      
      # If a change is detected, touch a file that Jekyll watches
      echo -e "${YELLOW}Data file change detected! Triggering rebuild...${NC}"
      
      # Force Jekyll to rebuild by touching an index file
      find . -name "index.*" | head -n 1 | xargs touch
      
      # Wait a bit to avoid rapid consecutive builds
      sleep 1
    done
  ) &
  
  # Store the background process ID
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
  fi
  
  echo -e "${GREEN}Cleanup done. Goodbye!${NC}"
  exit 0
}

# Main process
main() {
  # Check if inotifywait is available
  if ! command -v inotifywait &> /dev/null; then
    echo -e "${RED}inotifywait command not found. Installing inotify-tools...${NC}"
    sudo apt-get update && sudo apt-get install -y inotify-tools
  fi

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
  
  # Then start the server with livereload
  echo -e "${GREEN}Starting live server...${NC}"
  echo -e "${YELLOW}NOTE: Data file changes will trigger a full page reload${NC}"
  
  # DO NOT use incremental mode since we need to rebuild on data changes
  bundle exec jekyll serve --livereload
}

# Execute the main process
main "$@"
