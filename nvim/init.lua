-- ============================================================================
-- init.lua - yolomcswaggins Neovim Config
-- ============================================================================
-- Bootstrap lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Compatibility shims for Neovim deprecations
-- Prefer the newer `vim.islist` API; if present, map `vim.tbl_islist` to it
-- to avoid deprecation warnings from plugins that still call `vim.tbl_islist`.
if vim.islist then
  vim.tbl_islist = vim.islist
end

-- Set leader key before loading plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load core configuration
require("yolomcswaggins.core.options")
require("yolomcswaggins.core.keymaps")
require("yolomcswaggins.core.autocmds")

-- Load plugins (lazy.nvim will handle loading plugin configs)
require("yolomcswaggins.plugins")
