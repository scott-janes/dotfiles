#!/usr/bin/env bash
# wezterm.sh - WezTerm config install script
set -e
REPO_DIR="$(cd "$(dirname "$0")"/../.. && pwd)"
CONFIG_SRC="$REPO_DIR/wezterm/wezterm.lua"
CONFIG_DEST="$HOME/.wezterm.lua"
source "$REPO_DIR/scripts/core/helpers.sh"

msg "Refreshing wezterm config..."
ensure_config_dir
refresh_config_dir "$(dirname "$CONFIG_DEST")"
copy_config "$CONFIG_SRC" "$CONFIG_DEST"
msg "wezterm config refreshed."
