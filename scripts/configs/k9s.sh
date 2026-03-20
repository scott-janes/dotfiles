#!/usr/bin/env bash
set -e

# Source color helpers, if available
if [[ -f "${BASH_SOURCE%/*}/../core/helpers.sh" ]]; then
  source "${BASH_SOURCE%/*}/../core/helpers.sh"
fi

REPO_CONFIG="$(pwd)/k9s/config.yaml"
TARGET_CONFIG="${HOME}/Library/Application Support/k9s/config.yaml"
REPO_SKINS_DIR="$(pwd)/k9s/skins"
TARGET_SKINS_DIR="${HOME}/Library/Application Support/k9s/skins"

# Ensure destination directories exist
mkdir -p "$(dirname "$TARGET_CONFIG")"
mkdir -p "$TARGET_SKINS_DIR"

# Overwrite target config with repo config
cp -f "$REPO_CONFIG" "$TARGET_CONFIG"

# Overwrite skins directory (remove existing for clean sync)
rm -rf "$TARGET_SKINS_DIR"
cp -r "$REPO_SKINS_DIR" "$TARGET_SKINS_DIR"

if [[ -f "$TARGET_CONFIG" ]]; then
  msg "k9s config.yaml overwritten at: $TARGET_CONFIG"
else
  warn "Failed to write k9s config.yaml!"
  exit 1
fi

if [[ -d "$TARGET_SKINS_DIR" ]]; then
  msg "k9s skins directory synced at: $TARGET_SKINS_DIR"
else
  warn "Failed to sync k9s skins directory!"
  exit 1
fi
