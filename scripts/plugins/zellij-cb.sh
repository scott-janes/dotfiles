#!/bin/bash
# scripts/plugins/zellij-cb.sh
# Install zellij-cb plugin (compact bar)

set -e
PLUGIN_DIR="$(dirname "$0")/../..//zellij/plugins"
WASM="zellij-cb.wasm"
RELEASE="https://github.com/ndavd/zellij-cb/releases/latest/download/$WASM"

mkdir -p "$PLUGIN_DIR"
echo "Downloading zellij-cb.wasm to $PLUGIN_DIR..."
curl -L "$RELEASE" -o "$PLUGIN_DIR/$WASM"
echo "zellij-cb installed!"
