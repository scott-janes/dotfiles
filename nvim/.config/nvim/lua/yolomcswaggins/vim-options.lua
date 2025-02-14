local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
local option = vim.api.nvim_set_option

vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "
local function map_key(mode, lhs, rhs, desc)
  local key_opts = vim.tbl_extend("force", opts, { desc = desc })
  vim.keymap.set(mode, lhs, rhs, key_opts)
end
map_key("n", "<C-h>", "<C-w>h", "Move to left window")
map_key("n", "<C-j>", "<C-w>j", "Move to below window")
map_key("n", "<C-k>", "<C-w>k", "Move to above window")
map_key("n", "<C-l>", "<C-w>l", "Move to right window")
map_key("n", "<C-b>n", ":Neotree filesystem reveal left<CR>", "Open neotree")
map_key("n", "<C-b>b", ":Neotree close<CR>", "Close Neotree")
keymap("n", "x", '"_x')


vim.g.maplocalleader = ","

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Save file by CTRL-S
map_key("n", "<C-s>", ":w<CR>", "Save file")
map_key("i", "<C-s>", "<ESC> :w<CR>", "Save file")

map_key("n", "<leader>z", ":ZenMode<CR>", "Toggle ZenMode")

-- option("clipboard", "unnamedplus")
option("ignorecase", true)
option("smartindent", true)
option("splitright", true)
option("undofile", true)
option("wrap", true)
option("incsearch", true)
option("scrolloff", 10)
option("sidescrolloff", 10)
vim.opt.hlsearch = true
vim.opt.title = true
vim.opt.backup = false

if vim.fn.has("wsl") == 1 then
  vim.g.clipboard = {
    name = "WslClipboard",
    copy = {
      ["+"] = "clip.exe",
      ["*"] = "clip.exe",
    },
    paste = {
      ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
  }
end
vim.opt.clipboard = "unnamedplus"

vim.wo.number = true
vim.wo.cursorline = true
