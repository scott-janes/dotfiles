#!/usr/bin/env bash
# osx-ui.sh - restore Scott's preferred macOS Dock and menu bar UI settings
set -e
REPO_DIR="$(cd "$(dirname "$0")"/../.. && pwd)"
source "$REPO_DIR/scripts/core/helpers.sh"

msg "Applying preferred Dock and menu bar settings..."

# Dock: auto-hide ON
defaults write com.apple.dock autohide -bool true

# Dock: icon size (your current)
defaults write com.apple.dock tilesize -int 16

# Menu bar: auto-hide ON
defaults write NSGlobalDomain _HIHideMenuBar -bool true

# Apply changes immediately
killall Dock 2>/dev/null || true

msg "Dock and menu bar settings applied."
