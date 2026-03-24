-- Shared constants for language servers and formatters

local M = {}

-- List of LSP servers for Mason and lsp.lua
M.lsp_servers = {
  "eslint",       -- ESLint
  "lua_ls",       -- Lua
  "gopls",        -- Go
  "terraformls",  -- Terraform
  "bashls",       -- Bash
  "jsonls",       -- JSON
  "yamlls",       -- YAML
}

-- Formatter setup for conform.nvim
M.formatters_by_ft = {
  lua = { "stylua" },
  javascript = { "prettierd", "prettier", stop_after_first = true },
  typescript = { "prettierd", "prettier", stop_after_first = true },
  javascriptreact = { "prettierd", "prettier", stop_after_first = true },
  typescriptreact = { "prettierd", "prettier", stop_after_first = true },
  json = { "prettierd", "prettier", stop_after_first = true },
  yaml = { "prettierd", "prettier", stop_after_first = true },
  markdown = { "prettierd", "prettier", stop_after_first = true },
  go = { "gofumpt", "goimports" },
  terraform = { "terraform_fmt" },
  tf = { "terraform_fmt" },
}

return M
