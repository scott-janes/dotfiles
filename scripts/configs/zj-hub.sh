#!/usr/bin/env bash
# zj-hub.sh - Zj-hub config install, modular
set -e
REPO_DIR="$(cd "$(dirname "$0")"/../.. && pwd)"
CONFIG_SRC="$REPO_DIR/zj-hub"
CONFIG_DEST="$HOME/.config/zj-hub"
source "$REPO_DIR/scripts/core/helpers.sh"

msg "Refreshing zj-hub config..."
ensure_config_dir
refresh_config_dir "$CONFIG_DEST"
copy_config "$CONFIG_SRC" "$CONFIG_DEST"
msg "zj-hub config refreshed."
