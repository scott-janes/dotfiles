#!/usr/bin/env bash
set -e

REPO_DIR="$(cd "$(dirname "$0")"/../.. && pwd)"
CONFIG_SRC="$REPO_DIR/wezterm/wezterm.lua"
CONFIG_DEST="$HOME/.wezterm.lua"

source "$REPO_DIR/scripts/core/helpers.sh"

msg "Refreshing wezterm config..."

copy_config "$CONFIG_SRC" "$CONFIG_DEST"

msg "wezterm config refreshed."
