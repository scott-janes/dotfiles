#!/usr/bin/env bash
# zellij.sh - Zellij config install, modular
set -e
REPO_DIR="$(cd "$(dirname "$0")"/../.. && pwd)"
CONFIG_SRC="$REPO_DIR/zellij"
CONFIG_DEST="$HOME/.config/zellij"
source "$REPO_DIR/scripts/core/helpers.sh"

msg "Refreshing zellij config..."

# Always fetch latest zellij-cb plugin WASM before copying config
PLUGIN_INSTALL_SCRIPT="$REPO_DIR/scripts/plugins/zellij-cb.sh"
msg "Fetching latest zellij-cb plugin..."
bash "$PLUGIN_INSTALL_SCRIPT"

ensure_config_dir
refresh_config_dir "$CONFIG_DEST"
copy_config "$CONFIG_SRC" "$CONFIG_DEST"

msg "zellij config refreshed."
