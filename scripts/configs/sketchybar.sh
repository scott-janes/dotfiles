#!/usr/bin/env bash
# sketchybar.sh - Sketchybar config install, modular
set -e
REPO_DIR="$(cd "$(dirname "$0")"/../.. && pwd)"
CONFIG_SRC="$REPO_DIR/sketchybar"
CONFIG_DEST="$HOME/.config/sketchybar"
source "$REPO_DIR/scripts/core/helpers.sh"

msg "Refreshing sketchybar config..."
ensure_config_dir
refresh_config_dir "$CONFIG_DEST"
copy_config "$CONFIG_SRC" "$CONFIG_DEST"
msg "sketchybar config refreshed."

# SbarLua install
SBARLUA_DIR="$HOME/.local/share/sketchybar_lua"
if [ ! -d "$SBARLUA_DIR" ]; then
  msg "SbarLua not found in $SBARLUA_DIR. Installing..."
  git clone https://github.com/FelixKratz/SbarLua.git /tmp/SbarLua
  cd /tmp/SbarLua/
  make install
  cd "$REPO_DIR" # return to repo root
  rm -rf /tmp/SbarLua/
  msg "SbarLua installed in $SBARLUA_DIR!"
else
  msg "SbarLua already installed at $SBARLUA_DIR, skipping."
fi
