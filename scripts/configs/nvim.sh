#!/usr/bin/env bash
# nvim.sh - Neovim config install, modular
set -e
REPO_DIR="$(cd "$(dirname "$0")"/../.. && pwd)"
CONFIG_SRC="$REPO_DIR/nvim"
CONFIG_DEST="$HOME/.config/nvim"
source "$REPO_DIR/scripts/core/helpers.sh"

msg "Refreshing neovim config..."
ensure_config_dir
refresh_config_dir "$CONFIG_DEST"
copy_config "$CONFIG_SRC" "$CONFIG_DEST"
msg "neovim config refreshed."
