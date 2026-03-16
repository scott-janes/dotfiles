#!/usr/bin/env bash
set -e

# asdf install/config script - modular for dotfiles bootstrap
# Usage: Called by setup.sh or directly, manages ASDF install, plugin, versions
# Add/modify language plugins and versions below

## 1. Install ASDF via Homebrew if not present
if ! command -v asdf >/dev/null 2>&1; then
  echo "[ASDF] Installing asdf via Homebrew..."
  brew install asdf
else
  echo "[ASDF] Already installed."
fi

## 2. Ensure shims path in .zshrc (Bash logic can be added similarly if needed)
if ! grep -q 'asdf' "$HOME/.zshrc"; then
  echo 'export PATH="$HOME/.asdf/shims:$PATH"' >> "$HOME/.zshrc"
fi

## 3. Only install missing plugin dependencies
missing_deps=()
for dep in gpg gawk coreutils; do
  if ! command -v "$dep" >/dev/null 2>&1; then
    missing_deps+=("$dep")
  fi
done
if [ "${#missing_deps[@]}" -gt 0 ]; then
  echo "[ASDF] Installing missing dependencies: ${missing_deps[*]}"
  brew install "${missing_deps[@]}"
else
  echo "[ASDF] All dependencies present."
fi

## 4. Plugins URLs (add new tools here)
declare -A plugins=(
  [nodejs]="https://github.com/asdf-vm/asdf-nodejs.git"
  [golang]="https://github.com/asdf-community/asdf-golang.git"
  [rust]="https://github.com/asdf-community/asdf-rust.git"
)

## 5. Per-language version arrays
nodejs_versions=("latest:lts")
golang_versions=("latest")
rust_versions=("latest")

## 6. Add plugins only once
for lang in "${!plugins[@]}"; do
  echo "[ASDF] Adding plugin $lang..."
  asdf plugin add "$lang" "${plugins[$lang]}" || true
done

## 7. Install + set versions for each language
echo "[ASDF] Installing Node.js versions..."
for version in "${nodejs_versions[@]}"; do
  asdf install nodejs "$version"
  asdf set nodejs "$version"
  asdf reshim nodejs
done

echo "[ASDF] Installing Go versions..."
for version in "${golang_versions[@]}"; do
  asdf install golang "$version"
  asdf set golang "$version"
  asdf reshim golang
done

echo "[ASDF] Installing Rust versions..."
for version in "${rust_versions[@]}"; do
  asdf install rust "$version"
  asdf set rust "$version"
  asdf reshim rust
done

## 8. Source Go env in .zshrc if not already
if ! grep -q "golang/set-env.zsh" "$HOME/.zshrc"; then
  echo ". $HOME/.asdf/plugins/golang/set-env.zsh" >> "$HOME/.zshrc"
fi

## 9. Optionally add usage notes (like package files)
echo "[ASDF] Optionally: add .default-npm-packages, .default-golang-pkgs, .default-rust-pkgs for auto global package install!"

echo "[ASDF] Done! Edit version arrays above to manage more versions, or add plugins to the top."
exit 0
