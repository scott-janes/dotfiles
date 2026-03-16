#!/usr/bin/env bash
# helpers.sh - Shared shell functions for dotfiles setup

# Print green message
msg() { echo -e "\033[0;32m$1\033[0m"; }
# Print yellow warning
warn() { echo -e "\033[1;33m$1\033[0m"; }

# Ensure ~/.config exists
ensure_config_dir() {
  if [ ! -d "$HOME/.config" ]; then
    mkdir -p "$HOME/.config"
  fi
}

# Clean and recreate a config directory
refresh_config_dir() {
  local dest="$1"
  rm -rf "$dest"
  mkdir -p "$dest"
}

# Copy configuration files
copy_config() {
  local src="$1"
  local dest="$2"
  cp -r "$src"/* "$dest"/
}
