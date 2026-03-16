# Dodgy Dotfiles (Now Tidied Up!)

## What’s in this repo?
Personal dotfiles for:

- aerospace
- borders
- nvim (Neovim)
- sketchybar
- zellij
- zsh

## Setup (macOS, Modern & Automated)

**Clone your dotfiles wherever you want, then do:**

```bash
cd ~/dotfiles   # or wherever you cloned
```

### First-Time Bootstrap (Essentials for macOS)
Run this first if you’re setting up a new Mac:
```bash
./setup.sh first-time
```
- Installs Xcode command line tools, Homebrew, and Oh My Zsh

### Full Dotfiles Install
```bash
./setup.sh
```
- Installs all configs to ~/.config and dotfiles to ~
- Installs Brewfile packages
- Ensures ~/.zshrc and ~/.zsh_aliases are up to date

### Install Just Brewfile Packages
```bash
./setup.sh install
```

### Install Individual Config
```bash
./setup.sh <config>
# Example:
./setup.sh nvim
```

## What’s gone?
- No old stow logic
- No Makefile
- No Windows/WSL cruft

## Notes
- All configs are now flat in repo (e.g., nvim/init.lua, sketchybar/bar.lua)
- `.zsh_aliases` is managed and sourced in `.zshrc`
- Scripts are idempotent and friendly
- See `first-time.sh` for what runs only once (brew, oh-my-zsh, xcode tools)

## Safe to Use
This setup is robust for fresh macOS installs. You can run scripts and overwrite existing configs—they’ll always reflect your repo as source of truth.

---

Feel free to fork, adapt, or request more features!
