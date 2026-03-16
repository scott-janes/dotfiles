#!/usr/bin/env bash
# zsh.sh - Zsh dotfiles install, modular
set -e
REPO_DIR="$(cd "$(dirname "$0")"/../.. && pwd)"
ZSH_SRC="$REPO_DIR/zsh/.zshrc"
ZSH_DEST="$HOME/.zshrc"
ALIASES_SRC="$REPO_DIR/zsh/.zsh_aliases"
ALIASES_DEST="$HOME/.zsh_aliases"
PLUGINS_SRC="$REPO_DIR/zsh/.zsh/.zsh-plugins"
PLUGINS_DEST="$HOME/.zsh/.zsh-plugins"
source "$REPO_DIR/scripts/core/helpers.sh"

msg "Refreshing .zshrc..."
rm -f "$ZSH_DEST"
cp "$ZSH_SRC" "$ZSH_DEST"
msg "Copying .zsh_aliases..."
rm -f "$ALIASES_DEST"
cp "$ALIASES_SRC" "$ALIASES_DEST"

# Ensure ~/.zsh exists and copy plugins file
msg "Copying .zsh-plugins..."
mkdir -p "$HOME/.zsh"
cp "$PLUGINS_SRC" "$PLUGINS_DEST"

LOCAL_SRC="$REPO_DIR/zsh/.zshrc.local"
LOCAL_DEST="$HOME/.zshrc.local"
if [ -f "$LOCAL_SRC" ]; then
    msg "Installing .zshrc.local (host overrides)..."
    if [ ! -f "$LOCAL_DEST" ]; then
        cp "$LOCAL_SRC" "$LOCAL_DEST"
        msg ".zshrc.local copied to home directory."
    else
        msg ".zshrc.local already exists in home, not overwriting."
    fi
else
    msg "No .zshrc.local found in repo, skipping local config setup."
fi
msg "zsh dotfiles installed."
