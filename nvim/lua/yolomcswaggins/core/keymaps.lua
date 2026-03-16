-- ============================================================================
-- Core Keymaps - Leader-based keybindings (which-key provides the menu)
-- ============================================================================
-- NOTE: Most keybindings are registered with which-key in the plugins config
-- This file contains only essential core mappings

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize windows with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Better paste (don't yank replaced text)
keymap("v", "p", '"_dP', opts)

-- Keep cursor centered when jumping
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Clear search highlighting with ESC
keymap("n", "<Esc>", ":nohlsearch<CR>", opts)

-- Quick save
keymap("n", "<C-s>", ":w<CR>", opts)
keymap("i", "<C-s>", "<Esc>:w<CR>", opts)

-- Quit
keymap("n", "<leader>q", ":q<CR>", { desc = "Quit" })
keymap("n", "<leader>Q", ":qa!<CR>", { desc = "Quit all (force)" })

-- All other leader keybindings are registered in plugins via which-key

-- Copilot keybindings
keymap("n", "<leader>ca", ":Copilot panel<CR>", { desc = "Open Copilot panel" })
-- copilot.lua suggestion accept/dismiss are handled by copilot.lua keymaps (configured in tools/copilot.lua)
