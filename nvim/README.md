# Neovim Configuration

This Neovim configuration is optimized for development on CachyOS with full LSP support, formatting, and modern plugin management.

## Features

- **Plugin Manager**: lazy.nvim for fast, declarative plugin management
- **Colorscheme**: Tokyo Night Moon theme
- **LSP Support**: Full language server protocol support via nvim-lspconfig + Mason
- **Autocompletion**: nvim-cmp with snippet support (LuaSnip)
- **Fuzzy Finding**: Telescope for file/text search
- **File Explorer**: nvim-tree for project navigation
- **Syntax Highlighting**: Treesitter for advanced parsing
- **Git Integration**: gitsigns for inline git blame/diff
- **Formatting**: conform.nvim with manual trigger (`<leader>gf`)
- **Status Line**: lualine for informative status bar

## Key Bindings

### General
- `<Space>` - Leader key
- `<leader>w` - Save file
- `<leader>q` - Quit
- `<C-h/j/k/l>` - Navigate between splits

### File Navigation
- `<leader>ff` - Find files (Telescope)
- `<leader>fg` - Live grep (search text)
- `<leader>fb` - Browse buffers
- `<leader>e` - Toggle file explorer

### LSP
- `gd` - Go to definition
- `gr` - Show references
- `K` - Show hover documentation
- `<leader>rn` - Rename symbol
- `<leader>ca` - Code actions
- `[d` / `]d` - Navigate diagnostics

### Formatting
- `<leader>gf` - Format current buffer (manual trigger only, no format-on-save)

### Git
- `<leader>gp` - Git preview hunk
- `<leader>gb` - Git blame line

## Expected First Launch Behavior

### What Happens Automatically

When you first launch Neovim after deployment:

1. **lazy.nvim bootstraps** (1-2 seconds)
   - Plugin manager auto-installs itself
   - All plugins are cloned from GitHub

2. **Mason installs LSP servers** (30-60 seconds)
   - Language servers install in background
   - Formatters and linters download automatically
   - You can continue editing while this happens

3. **Treesitter compiles parsers** (10-20 seconds)
   - Syntax parsers build for installed languages
   - One-time compilation per parser

**Expected packages from Mason:**
- `lua_ls` (Lua)
- `ts_ls` (TypeScript/JavaScript)
- `gopls` (Go)
- `pyright` (Python)
- `rust_analyzer` (Rust)
- `stylua` (Lua formatter)
- `prettier` (JS/TS/JSON formatter)
- `gofmt` (Go formatter)
- `black` (Python formatter)

### First Launch Timeline

```
0s    → Neovim opens, lazy.nvim installs (expect slow startup)
2s    → Plugins load, Mason starts background installs
5s    → UI becomes responsive, you can start editing
30s   → LSP servers finish installing
60s   → All Mason packages complete
```

### What You Should Do

1. **First launch**: Just open Neovim and wait ~60 seconds
   ```bash
   nvim
   ```

2. **Check installation progress**:
   ```vim
   :Lazy          " View plugin status
   :Mason         " View LSP/formatter install progress
   :checkhealth   " Verify everything works
   ```

3. **Wait for Mason to finish**: Look for "All packages installed" in `:Mason`

4. **Test LSP**: Open a code file and try `gd` (go to definition) or `K` (hover docs)

## Troubleshooting

### Issue: LSP not working after first launch

**Symptom**: No autocomplete, `gd` doesn't work, no diagnostics

**Solution**:
```vim
:Mason          " Check if servers are installed
:LspInfo        " Verify LSP client is attached
:checkhealth    " Run full health check
```

If servers show as "not installed":
```vim
:MasonInstall lua_ls ts_ls gopls pyright
```

### Issue: Formatters not working

**Symptom**: `<leader>gf` does nothing or shows errors

**Solution**:
```vim
:Mason          " Check if formatters are installed
:ConformInfo    " See which formatters are available
```

Manually install formatters:
```vim
:MasonInstall stylua prettier black gofmt
```

### Issue: Slow startup after first launch

**Symptom**: Neovim takes 5+ seconds to open after initial setup

**Solution**:
- This is normal for the first 2-3 launches while Treesitter compiles
- After parsers are built, startup should be <200ms
- Check compilation status: `:TSInstallInfo`

### Issue: Syntax highlighting broken

**Symptom**: Code appears in plain white/no colors

**Solution**:
```vim
:TSUpdate       " Update Treesitter parsers
:TSInstall lua typescript go python rust
```

### Issue: Telescope not finding files

**Symptom**: `<leader>ff` shows no results or errors

**Solution**:
- Ensure you're in a project directory
- Check dependencies: `rg` (ripgrep) and `fd` must be installed
- Verify in terminal: `which rg && which fd`

### Issue: Plugin errors on startup

**Symptom**: Error messages flash when opening Neovim

**Solution**:
```vim
:Lazy sync      " Re-sync all plugins
:Lazy clean     " Remove unused plugins
:Lazy update    " Update to latest versions
```

If errors persist:
```bash
rm -rf ~/.local/share/nvim
rm -rf ~/.cache/nvim
nvim  # Fresh start, plugins will reinstall
```

## Dependencies

These are installed by `runs/install/50-dev.sh`:

- **Required**:
  - `neovim` (>= 0.9.0)
  - `git` (for plugin management)
  - `nodejs` + `npm` (for many LSP servers)
  - `go` (for gopls and some tools)
  - `make` (for building native extensions)
  
- **Optional but recommended**:
  - `ripgrep` (for Telescope text search)
  - `fd` (for Telescope file finding)
  - `lazygit` (for advanced git integration)

## File Structure

```
config/nvim/
├── init.lua                    # Entry point, loads core + plugins
├── lua/
│   ├── core/
│   │   ├── options.lua         # Editor settings (tabs, line numbers, etc.)
│   │   ├── keymaps.lua         # Global key bindings
│   │   └── autocmds.lua        # Auto commands (not currently used)
│   └── plugins/
│       ├── lazy.lua            # Plugin manager setup
│       ├── colorscheme.lua     # Tokyo Night theme
│       ├── lsp.lua             # LSP + Mason configuration
│       ├── cmp.lua             # Autocompletion
│       ├── telescope.lua       # Fuzzy finder
│       ├── treesitter.lua      # Syntax parsing
│       ├── nvim-tree.lua       # File explorer
│       ├── conform.lua         # Formatting (<leader>gf trigger)
│       ├── gitsigns.lua        # Git integration
│       ├── lualine.lua         # Status line
│       ├── autopairs.lua       # Auto-close brackets
│       └── comment.lua         # Comment toggling
└── README.md                   # This file
```

## Updating Configuration

After making changes to config files:

1. **Reload Neovim**: `:source $MYVIMRC` or restart Neovim
2. **Sync plugins**: `:Lazy sync` (after modifying plugin specs)
3. **Update Mason packages**: `:Mason` then `U` to update all

## Philosophy

This configuration prioritizes:

- **Stability**: Pinned plugin versions, well-tested LSP servers
- **Performance**: Lazy loading, minimal startup time
- **Explicitness**: Manual formatting trigger, no hidden auto-actions
- **Discoverability**: Clear key bindings, helpful which-key hints (planned)
- **Portability**: Self-contained in `config/nvim/`, no external dependencies

## Resources

- [Neovim Docs](https://neovim.io/doc/)
- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [Mason](https://github.com/williamboman/mason.nvim)
- [Tokyo Night](https://github.com/folke/tokyonight.nvim)
