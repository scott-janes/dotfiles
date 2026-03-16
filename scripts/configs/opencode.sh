#!/usr/bin/env bash
# opencode.sh - Refresh opencode config and API key injection, modular
set -e
REPO_DIR="$(cd "$(dirname "$0")"/../.. && pwd)"
CONFIG_SRC="$REPO_DIR/opencode"
CONFIG_DEST="$HOME/.config/opencode"
JSON_SRC="$CONFIG_SRC/opencode.json"
JSON_DEST="$CONFIG_DEST/opencode.json"
source "$REPO_DIR/scripts/core/helpers.sh"

msg "Refreshing opencode config..."
ensure_config_dir
refresh_config_dir "$CONFIG_DEST"
cp "$JSON_SRC" "$JSON_DEST"
API_KEY="$OPENCODE_API_KEY"
if [ -z "$API_KEY" ]; then
  if [ -f "$REPO_DIR/.env" ]; then
    API_KEY=$(grep 'OPENCODE_API_KEY=' "$REPO_DIR/.env" | cut -d '=' -f2)
  fi
fi
if [ ! -z "$API_KEY" ]; then
  msg "Injecting OPENCODE_API_KEY into opencode.json"
  sed -i '' "s/YOUR_API_KEY_HERE/$API_KEY/g" "$JSON_DEST"
else
  warn "No OPENCODE_API_KEY found. Please update opencode.json manually."
fi
# Install plugins
# bash "$REPO_DIR/scripts/opencode-plugins.sh"
msg "opencode config refreshed."
