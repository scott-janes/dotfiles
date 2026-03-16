-- ============================================================================
-- Core Autocommands - Useful automatic behaviors
-- ============================================================================

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
  group = "YankHighlight",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- Abstract-autocmds replacements (smart paste, smart dd, move selection, clear search)
augroup("AbstractAutocmds", { clear = true })
autocmd("VimEnter", {
  group = "AbstractAutocmds",
  callback = function()
    -- Smart visual paste: do not overwrite unnamed register when pasting over visual selection
    vim.keymap.set("x", "p", [["_dP]], { noremap = true, silent = true })

    -- Move selected block up/down in visual mode (Alt-j / Alt-k)
    vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
    vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

    -- Smart dd: if the current line is empty or whitespace only, delete to blackhole
    vim.keymap.set("n", "dd", function()
      local line = vim.api.nvim_get_current_line()
      if line:match("^%s*$") then
        vim.cmd('normal! "_dd')
      else
        vim.cmd('normal! dd')
      end
    end, { noremap = true, silent = true })
  end,
})

-- Clear last used search when entering a buffer (prevents leftover search highlights)
autocmd("BufEnter", {
  group = "AbstractAutocmds",
  pattern = "*",
  callback = function()
    pcall(vim.fn.setreg, "/", "")
    vim.opt.hlsearch = false
  end,
})

-- Remove trailing whitespace on save
augroup("TrimWhitespace", { clear = true })
autocmd("BufWritePre", {
  group = "TrimWhitespace",
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- Auto-resize splits when terminal is resized
augroup("ResizeSplits", { clear = true })
autocmd("VimResized", {
  group = "ResizeSplits",
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- Close certain file types with 'q'
augroup("CloseWithQ", { clear = true })
autocmd("FileType", {
  group = "CloseWithQ",
  pattern = { "qf", "help", "man", "lspinfo", "checkhealth" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Don't auto-comment new lines
augroup("NoAutoComment", { clear = true })
autocmd("BufEnter", {
  group = "NoAutoComment",
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- Go to last location when opening a buffer
augroup("LastLocation", { clear = true })
autocmd("BufReadPost", {
  group = "LastLocation",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
