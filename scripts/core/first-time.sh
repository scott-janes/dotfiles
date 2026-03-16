#!/usr/bin/env bash
# first-time.sh - One-time setup for macOS dev environment
set -e

COL_GREEN="\033[0;32m"
COL_YELLOW="\033[1;33m"
COL_RESET="\033[0m"

msg() { echo -e "${COL_GREEN}$1${COL_RESET}"; }
warn() { echo -e "${COL_YELLOW}$1${COL_RESET}"; }

# Homebrew install
install_brew() {
  if ! command -v brew > /dev/null; then
    msg "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    msg "Homebrew found. Skipping install."
  fi
}

# Oh My Zsh install
install_oh_my_zsh() {
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    msg "Installing Oh My Zsh..."
    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  else
    msg "Oh My Zsh already installed."
  fi
}

msg "Starting first-time setup!"

# Create ~/git directory
if [ ! -d "$HOME/git" ]; then
  msg "Creating ~/git directory..."
  mkdir -p "$HOME/git"
else
  msg "~/git directory already exists."
fi

# Install Xcode Command Line Tools
if ! xcode-select -p > /dev/null 2>&1; then
  msg "Installing Xcode Command Line Tools..."
  xcode-select --install || warn "Manual intervention may be needed for Xcode tools!"
else
  msg "Xcode Command Line Tools already installed."
fi

install_brew
install_oh_my_zsh
msg "First-time setup complete! 🎉"
