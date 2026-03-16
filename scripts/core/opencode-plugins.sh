#!/usr/bin/env bash
# opencode plugins install
set -e

COL_GREEN="\033[0;32m"
msg() { echo -e "${COL_GREEN}$1\033[0m"; }

msg "Installing opencode plugins..."
npm install -g @mohak34/opencode-notifier@latest
msg "opencode-mystatus is a built-in plugin."
msg "Plugin install step complete."
