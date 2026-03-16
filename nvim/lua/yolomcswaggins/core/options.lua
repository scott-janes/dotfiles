-- ============================================================================
-- Core Options - Sensible defaults for modern Neovim
-- ============================================================================

local opt = vim.opt

-- UI & Appearance
opt.termguicolors = true              -- Enable 24-bit RGB colors
opt.number = true                     -- Show line numbers
opt.relativenumber = true             -- Relative line numbers for easy navigation
opt.cursorline = true                 -- Highlight current line
opt.signcolumn = "yes"                -- Always show sign column (prevents text shift)
opt.colorcolumn = "120"               -- Show ruler at 120 chars
opt.wrap = false                      -- Disable line wrap
opt.scrolloff = 8                     -- Keep 8 lines visible above/below cursor
opt.sidescrolloff = 8                 -- Keep 8 columns visible left/right of cursor
opt.showmode = false                  -- Don't show mode (statusline handles this)
opt.conceallevel = 0                  -- Don't hide quotes in JSON/markdown

-- Indentation
opt.tabstop = 2                       -- Tab width = 2 spaces
opt.shiftwidth = 2                    -- Indent width = 2 spaces
opt.expandtab = true                  -- Convert tabs to spaces
opt.smartindent = true                -- Smart auto-indenting
opt.breakindent = true                -- Wrapped lines respect indent

-- Search
opt.ignorecase = true                 -- Case-insensitive search
opt.smartcase = true                  -- Unless search contains uppercase
opt.hlsearch = true                   -- Highlight search results
opt.incsearch = true                  -- Incremental search

-- Splits
opt.splitbelow = true                 -- Horizontal splits open below
opt.splitright = true                 -- Vertical splits open right

-- Editing
opt.mouse = "a"                       -- Enable mouse support
opt.clipboard = "unnamedplus"         -- Use system clipboard
opt.undofile = true                   -- Persistent undo
opt.updatetime = 250                  -- Faster completion (default: 4000ms)
opt.timeoutlen = 300                  -- Time to wait for mapped sequence
opt.completeopt = "menu,menuone,noselect" -- Better completion experience
opt.pumheight = 10                    -- Popup menu height

-- Files
opt.swapfile = false                  -- Disable swap files
opt.backup = false                    -- Disable backup files
opt.fileencoding = "utf-8"            -- File encoding

-- Performance
opt.lazyredraw = false                -- Don't redraw during macros (set false for noice.nvim)
opt.synmaxcol = 240                   -- Only syntax highlight first 240 columns

-- Neovim-specific
opt.isfname:append("@-@")             -- Consider @ as part of filename
opt.shortmess:append("c")             -- Don't show completion messages
opt.fillchars = { eob = " " }         -- Hide ~ at end of buffer

-- Disable built-in providers (use Mason-installed tools)
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
