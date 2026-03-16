#!/usr/bin/env bash
# borders.sh - Borders config install, modular
set -e
REPO_DIR="$(cd "$(dirname "$0")"/../.. && pwd)"
CONFIG_SRC="$REPO_DIR/borders"
CONFIG_DEST="$HOME/.config/borders"
source "$REPO_DIR/scripts/core/helpers.sh"

msg "Refreshing borders config..."
ensure_config_dir
refresh_config_dir "$CONFIG_DEST"
copy_config "$CONFIG_SRC" "$CONFIG_DEST"
msg "borders config refreshed."
