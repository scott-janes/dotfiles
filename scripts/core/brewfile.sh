#!/usr/bin/env bash
# brewfile.sh - Runs Brewfile installs
set -e
REPO_DIR="$(cd "$(dirname "$0")" && cd ../.. && pwd)"
BREWFILE="$REPO_DIR/Brewfile"
echo "Installing Brewfile packages..."
brew bundle --file="$BREWFILE"
echo "Brewfile install complete."
