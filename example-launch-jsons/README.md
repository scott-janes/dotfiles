# Example `.vscode/launch.json` Configurations

This folder contains example launch configurations for Node.js, TypeScript, NestJS, Jest (tests), and more.

These files are compatible with both VS Code and Neovim debug setups (including `nvim-dap` with the snacks.nvim UI, as documented in this repo).

---

## Using These Examples

1. **Copy** the desired `launch.json` into your project’s `.vscode/` folder:
   ```bash
   mkdir -p .vscode
   cp /path/to/dotfiles/example-launch-jsons/launch.nestjs.json .vscode/launch.json
   ```
2. **Adjust paths as needed** for your project (for example, set the correct `program` entry point, or adjust `cwd`).
3. (Optional) Add more configurations or modify env vars, runtime arguments, etc.

---

## Available Examples

- `launch.nestjs.json` – Debug a NestJS app with ts-node (Node + TypeScript)
- `launch.jest.json` – Debug Jest unit tests with ts-node & Node.js
- (Add your own and contribute more patterns!)

---

## Why per-project launch.json?

- Makes debugging repeatable and shareable!
- Ensures **VS Code** and **Neovim** can both use the same config (dev team parity).
- Keeps debug settings portable between editors.

---

## Resources
- [VS Code Debugging Docs](https://code.visualstudio.com/docs/editor/debugging)
- [nvim-dap Documentation](https://github.com/mfussenegger/nvim-dap)
- [snacks.nvim Modern UI](https://github.com/folke/snacks.nvim)

---
