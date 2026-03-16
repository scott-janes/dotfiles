#!/usr/bin/env bash
# aerospace.sh - Aerospace config install, modular
set -e
REPO_DIR="$(cd "$(dirname "$0")"/../.. && pwd)"
CONFIG_SRC="$REPO_DIR/aerospace"
CONFIG_DEST="$HOME/.config/aerospace"
source "$REPO_DIR/scripts/core/helpers.sh"

msg "Refreshing aerospace config..."
ensure_config_dir
refresh_config_dir "$CONFIG_DEST"
copy_config "$CONFIG_SRC" "$CONFIG_DEST"
msg "aerospace config refreshed."
