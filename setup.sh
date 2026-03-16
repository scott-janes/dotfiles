#!/usr/bin/env bash
# setup.sh - Dynamically orchestrates modular scripts by subfolder for dotfiles setup (macOS)
set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
SCRIPTS_DIR="$REPO_DIR/scripts"
CORE_DIR="$SCRIPTS_DIR/core"
CONFIGS_DIR="$SCRIPTS_DIR/configs"
DOTFILES_DIR="$SCRIPTS_DIR/dotfiles"

EXCLUDE_CORE=(helpers.sh first-time.sh brewfile.sh opencode-plugins.sh)

msg() { echo -e "\033[0;32m$1\033[0m"; }
warn() { echo -e "\033[1;33m$1\033[0m"; }

should_exclude_core() {
  local fname="$1"
  for excl in "${EXCLUDE_CORE[@]}"; do
    if [[ "$fname" == "$excl" ]]; then
      return 0
    fi
  done
  return 1
}

run_brewfile() {
  bash "$CORE_DIR/brewfile.sh"
}

refresh_all() {
  msg "Starting full dotfiles setup!"
  bash "$CORE_DIR/first-time.sh"
  run_brewfile
  
  for script in "$CONFIGS_DIR"/*.sh; do
    fname=$(basename "$script")
    msg "Running config: $fname..."
    bash "$script"
  done

  for script in "$DOTFILES_DIR"/*.sh; do
    fname=$(basename "$script")
    msg "Running dotfile: $fname..."
    bash "$script"
  done

  msg "All configs, Brewfile, plugins and dotfiles installed! 🎉"
}

setup_one() {
  local name="$1"
  if [ -f "$CONFIGS_DIR/$name.sh" ]; then
    msg "Running $name.sh from configs..."
    bash "$CONFIGS_DIR/$name.sh"
    msg "$name config setup complete."
  elif [ -f "$DOTFILES_DIR/$name.sh" ]; then
    msg "Running $name.sh from dotfiles..."
    bash "$DOTFILES_DIR/$name.sh"
    msg "$name dotfile setup complete."
  else
    warn "Script $name.sh not found in configs/ or dotfiles/."
    exit 1
  fi
}

# Main logic

type="$1"
if [ -z "$type" ]; then
  refresh_all
elif [ "$type" == "install" ]; then
  run_brewfile
  msg "Homebrew & Brewfile complete!"
elif [ "$type" == "first-time" ]; then
  bash "$CORE_DIR/first-time.sh"
else
  setup_one "$type"
fi

msg "All done!"
