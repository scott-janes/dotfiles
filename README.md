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

## Debugging Node.js and TypeScript in Neovim (Modern Way)

For JavaScript/TypeScript (Node.js, Jest, Mocha, etc):
- Uses official Microsoft [vscode-js-debug](https://github.com/microsoft/vscode-js-debug) for nvim-dap, supporting launch/attach just like VS Code.
- Launch and debug configs are loaded automatically from local `.vscode/launch.json` (per project) using nvim-dap-projects (no need to define everything globally).

### Setup the Node.js Debug Adapter

**Manual Build (One-time):**

```bash
git clone https://github.com/microsoft/vscode-js-debug ~/vscode-js-debug
cd ~/vscode-js-debug
npm install --legacy-peer-deps
npx gulp dapDebugServer
```

This builds the debug adapter at:
```
~/vscode-js-debug/dist/src/dapDebugServer.js
```

### Neovim Config Snippet

In your Lua config (see `lua/yolomcswaggins/plugins_testing.lua`):

```lua
local dap = require("dap")
local js_debug_path = vim.fn.expand("$HOME/vscode-js-debug/dist/src/dapDebugServer.js")
dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    args = { js_debug_path, "${port}" },
  },
}
dap.adapters["node"] = function(cb, config)
  if config.type == "node" then
    config.type = "pwa-node"
  end
  local a = dap.adapters["pwa-node"]
  if type(a) == "function" then
    a(cb, config)
  else
    cb(a)
  end
end
-- No need to define JS/TS configs here if you use .vscode/launch.json per repo
```

### Per-Project `.vscode/launch.json`

- Place launch configs as you would for VS Code in `.vscode/launch.json` in each JS/TS repo.
- Use nvim-dap-projects to enable reading configs per project.

**Example launch.json:**
```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "pwa-node",
      "request": "launch",
      "name": "Debug NestJS Program",
      "skipFiles": ["<node_internals>/**"],
      "runtimeArgs": ["-r", "ts-node/register"],
      "program": "${workspaceFolder}/src/main.ts",
      "cwd": "${workspaceFolder}",
      "console": "integratedTerminal",
      "env": { "NODE_ENV": "development" }
    }
  ]
}
```

**Works exactly like VS Code's launch configs!**

---

Feel free to fork, adapt, or request more features!
