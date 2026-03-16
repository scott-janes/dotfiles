# Neovim Keybindings Cheatsheet

**Leader Key:** `<Space>`

## Core Navigation

| Keybinding | Description |
|------------|-------------|
| `<C-h>` | Move to left window |
| `<C-j>` | Move to bottom window |
| `<C-k>` | Move to top window |
| `<C-l>` | Move to right window |
| `<C-Up>` | Increase window height |
| `<C-Down>` | Decrease window height |
| `<C-Left>` | Decrease window width |
| `<C-Right>` | Increase window width |
| `<C-d>` | Scroll down (half page, centered) |
| `<C-u>` | Scroll up (half page, centered) |
| `<C-s>` | Save file |
| `<Esc>` | Clear search highlighting |

## Visual Mode

| Keybinding | Description |
|------------|-------------|
| `<` | Indent left (stay in visual mode) |
| `>` | Indent right (stay in visual mode) |
| `J` | Move text down |
| `K` | Move text up |
| `p` | Paste without yanking replaced text |

## File Explorer (Neo-tree)

| Keybinding | Description |
|------------|-------------|
| `<leader>e` | Toggle file explorer |
| `<Space>` | Toggle node (in neo-tree) |
| `<CR>` | Open file |
| `a` | Add file |
| `A` | Add directory |
| `d` | Delete |
| `r` | Rename |
| `c` | Copy |
| `m` | Move |
| `y` | Copy to clipboard |
| `x` | Cut to clipboard |
| `p` | Paste from clipboard |
| `S` | Open in horizontal split |
| `s` | Open in vertical split |
| `t` | Open in new tab |
| `H` | Toggle hidden files |
| `R` | Refresh |
| `q` | Close neo-tree window |

## Fuzzy Finding (Telescope)

| Keybinding | Description |
|------------|-------------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep (search in files) |
| `<leader>fb` | Find buffers |
| `<leader>fh` | Find help tags |
| `<leader>fo` | Find recently opened files |
| `<leader>fr` | Resume last telescope search |

### Telescope Navigation (Inside Telescope)

| Keybinding | Description |
|------------|-------------|
| `<C-j>` / `<Down>` | Move to next item |
| `<C-k>` / `<Up>` | Move to previous item |
| `<C-u>` | Preview scroll up |
| `<C-d>` | Preview scroll down |
| `<CR>` | Open selected file |
| `<C-x>` | Open in horizontal split |
| `<C-v>` | Open in vertical split |
| `<C-t>` | Open in new tab |
| `<C-q>` | Send to quickfix list |

## Harpoon (Quick File Navigation)

| Keybinding | Description |
|------------|-------------|
| `<leader>ha` | Add file to harpoon |
| `<leader>hh` | Toggle harpoon menu |
| `<leader>h1` | Jump to harpoon file 1 |
| `<leader>h2` | Jump to harpoon file 2 |
| `<leader>h3` | Jump to harpoon file 3 |
| `<leader>h4` | Jump to harpoon file 4 |

## Git

| Keybinding | Description |
|------------|-------------|
| `<leader>gg` | Open LazyGit |
| `<leader>gb` | Git blame line |
| `<leader>gp` | Preview hunk |
| `<leader>gr` | Reset hunk |
| `<leader>gs` | Stage hunk |
| `<leader>gu` | Undo stage hunk |

## LSP (Language Server Protocol)

| Keybinding | Description |
|------------|-------------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Go to references |
| `gi` | Go to implementation |
| `K` | Hover documentation |
| `<C-k>` | Signature help (insert mode) |
| `<leader>lr` | Rename symbol |
| `<leader>la` | Code action |
| `<leader>ld` | Show line diagnostics |
| `<leader>lq` | Send diagnostics to quickfix |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |
| `<leader>gf` | **Format buffer** (manual) |

## Go-Specific (Go files only)

| Keybinding | Description |
|------------|-------------|
| `<leader>gtt` | Run Go tests |
| `<leader>gtf` | Test current function |
| `<leader>gtp` | Test current package |
| `<leader>gc` | Show coverage |
| `<leader>gi` | Show implements |
| `<leader>ge` | Add if err |
| `<leader>gfs` | Fill struct |

## Completion (Insert Mode)

| Keybinding | Description |
|------------|-------------|
| `<C-Space>` | Trigger completion (nvim-cmp) |
| `<CR>` | Confirm selected completion (nvim-cmp) |
| `<Tab>` | Next completion / expand snippet / fallback to Copilot accept |
| `<S-Tab>` | Previous completion / jump backward in snippet |
| `<C-b>` | Scroll docs up |
| `<C-f>` | Scroll docs down |
| `<C-e>` | Abort completion |

Notes:
- nvim-cmp is configured with LSP, snippets and Copilot (via copilot-cmp). Tab prefers the completion menu, then LuaSnip, then tries Copilot's accept if nothing else applies.

## Copilot (inline suggestions)

| Keybinding | Description |
|------------|-------------|
| `<M-]>` (Alt-]) | Accept inline Copilot suggestion (configured in `lua/yolomcswaggins/tools/copilot.lua`) |
| `<C-]>` | Dismiss inline Copilot suggestion |
| `<M-;>` | Next Copilot suggestion |
| `<M-,>` | Previous Copilot suggestion |
| `<leader>ca` | Open Copilot panel |
| `<leader>cs` | Copilot setup |

Notes:
- `<M-]>` uses the Meta (Alt) key. If your terminal doesn't send Alt, press `Esc` followed by `]` as a fallback.
- Copilot's accept_word / accept_line are disabled in the config, so only the full inline accept mapping is active.

## Window Management

| Keybinding | Description |
|------------|-------------|
| `<leader>q` | Quit current window |
| `<leader>Q` | Quit all (force) |

## Treesitter Text Objects

| Keybinding | Description |
|------------|-------------|
| `<C-space>` | Incremental selection (init/expand) |
| `<BS>` | Shrink selection |
| `af` | Select outer function |
| `if` | Select inner function |
| `ac` | Select outer class |
| `ic` | Select inner class |

## Misc

| Keybinding | Description |
|------------|-------------|
| `<leader>?` | Show which-key help |
| `:Lazy` | Open lazy.nvim plugin manager |
| `:Mason` | Open Mason LSP installer |
| `:ConformInfo` | Show conform.nvim formatter info |
| `:checkhealth` | Run Neovim health checks |

## Tips

- **Which-key:** Press `<Space>` and wait 300ms to see available keybindings
- **Formatting:** Use `<leader>gf` to format the current buffer (no format-on-save)
- **Harpoon:** Mark your 4 most important files for instant access
- **Telescope:** Use `<C-q>` to send results to quickfix for batch operations
- **Neo-tree:** Press `?` inside neo-tree to see all available commands
