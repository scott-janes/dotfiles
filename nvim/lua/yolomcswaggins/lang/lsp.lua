-- ============================================================================
-- Language: LSP Configuration - Mason + LSP setup
-- ============================================================================

local lspconfig = require("lspconfig")
local lspconfigs = require("lspconfig.configs")
local mason_lspconfig = require("mason-lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

-- LSP servers to install automatically
local servers = {
  "eslint",       -- ESLint
  "lua_ls",       -- Lua
  "gopls",        -- Go
  "terraformls",  -- Terraform
  "bashls",       -- Bash
  "jsonls",       -- JSON
  "yamlls",       -- YAML
}

-- Setup Mason to auto-install LSP servers
mason_lspconfig.setup({
  ensure_installed = servers,
  automatic_installation = true,
})

-- Enhanced capabilities for nvim-cmp
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Common LSP keybindings
local on_attach = function(client, bufnr)
  local wk = require("which-key")
  local opts = { buffer = bufnr }

  -- Register LSP keybindings with which-key (use register + buffer)
  wk.add({
    { "gd", vim.lsp.buf.definition, desc = "Go to definition" },
    { "gD", vim.lsp.buf.declaration, desc = "Go to declaration" },
    { "gr", vim.lsp.buf.references, desc = "Go to references" },
    { "gi", vim.lsp.buf.implementation, desc = "Go to implementation" },
    { "K", vim.lsp.buf.hover, desc = "Hover documentation" },
    { "<C-k>", vim.lsp.buf.signature_help, desc = "Signature help", mode = "i" },
    { "l", group = "LSP" },
    { "lr", vim.lsp.buf.rename, desc = "Rename symbol" },
    { "la", vim.lsp.buf.code_action, desc = "Code action", mode = { "n", "v" } },
    { "ld", vim.diagnostic.open_float, desc = "Line diagnostics" },
    { "lq", vim.diagnostic.setloclist, desc = "Quickfix diagnostics" },
    { "[d", vim.diagnostic.goto_prev, desc = "Previous diagnostic" },
    { "]d", vim.diagnostic.goto_next, desc = "Next diagnostic" },
  }, { buffer = bufnr, version = 2 })

  -- TypeScript-specific which-key mappings (buffer-local). Use a nested
  -- `lt` prefix under the existing `l` (LSP) group to avoid colliding with
  -- generic LSP mappings.
  local ft = vim.bo[bufnr].filetype or ""
  if ft:match("typescript") or ft:match("javascript") or client.name == "tsserver" then
    pcall(function()
      wk.add({
        { "lt", group = "TypeScript" },
        { "lto", ":TSToolsOrganizeImports<CR>", desc = "Organize imports" },
        { "ltt", ":TSToolsSortImports<CR>", desc = "Sort imports" },
        { "ltm", ":TSToolsAddMissingImports<CR>", desc = "Add missing imports" },
        { "ltr", ":TSToolsRemoveUnusedImports<CR>", desc = "Remove unused imports" },
        { "ltR", ":TSToolsRemoveUnused<CR>", desc = "Remove unused" },
        { "ltf", ":TSToolsFixAll<CR>", desc = "Fix all" },
        { "ltg", ":TSToolsGoToSourceDefinition<CR>", desc = "Go to source definition" },
        { "ltn", ":TSToolsRenameFile<CR>", desc = "Rename file" },
        { "ltF", ":TSToolsFileReferences<CR>", desc = "File references" },
      }, { buffer = bufnr, version = 2 })
    end)
  end

  -- Highlight symbol under cursor
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
    vim.api.nvim_clear_autocmds({ buffer = bufnr, group = "lsp_document_highlight" })
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = "lsp_document_highlight",
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      group = "lsp_document_highlight",
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

-- Configure diagnostics display
vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
    source = "if_many",
  },
  signs = {
    Error = { text = " ", texthl = "DiagnosticSignError", numhl = "DiagnosticSignError" },
    Warn = { text = " ", texthl = "DiagnosticSignWarn", numhl = "DiagnosticSignWarn" },
    Hint = { text = " ", texthl = "DiagnosticSignHint", numhl = "DiagnosticSignHint" },
    Info = { text = " ", texthl = "DiagnosticSignInfo", numhl = "DiagnosticSignInfo" },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

-- LSP handlers with borders
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
})

-- Setup each LSP server. mason-lspconfig used to provide `setup_handlers`; newer
-- or alternative installs may not. Use it when present, otherwise fall back to
-- manually configuring servers listed in `servers`.
if type(mason_lspconfig.setup_handlers) == "function" then
  mason_lspconfig.setup_handlers({
    -- Default handler for all servers
    function(server_name)
      local configs = require("lspconfig.configs")
      local server_mod = configs[server_name]
      if not server_mod then
        local ok, config = pcall(require, "lspconfig.configs." .. server_name)
        if ok and config then
          server_mod = config
          configs[server_name] = config
        end
      end
      if server_mod and type(server_mod.setup) == "function" then
        server_mod.setup({ on_attach = on_attach, capabilities = capabilities })
      end
    end,

    -- ts_ls custom handler
    ["tsserver"] = function()
      -- Prefer using pmizio/typescript-tools.nvim which talks directly to tsserver.
      local ok, ts_tools = pcall(require, "typescript-tools")
      if ok and ts_tools then
        ts_tools.setup({
          on_attach = function(client, bufnr)
            -- keep formatting disabled so external formatters handle formatting
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
            on_attach(client, bufnr)
          end,
          capabilities = capabilities,
          settings = {
            -- prefer project-local tsserver; if you want to force Mason's tsserver,
            -- set tsserver_path to vim.fn.stdpath("data") .. "/mason/packages/typescript/node_modules/typescript/lib/tsserver.js"
            tsserver_path = nil,
            tsserver_file_preferences = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
            },
            tsserver_format_options = {},
          },
        })
      else
        -- Fallback to regular lspconfig tsserver setup if typescript-tools isn't available
        if lspconfig.tsserver and type(lspconfig.tsserver.setup) == "function" then
          lspconfig.tsserver.setup({
            on_attach = function(client, bufnr)
              client.server_capabilities.documentFormattingProvider = false
              client.server_capabilities.documentRangeFormattingProvider = false
              on_attach(client, bufnr)
            end,
            capabilities = capabilities,
          })
        end
      end
    end,

    -- lua_ls custom handler
    ["lua_ls"] = function()
      lspconfigs.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
            telemetry = { enable = false },
            format = { enable = false },
          },
        },
      })
    end,

    -- gopls
    ["gopls"] = function()
      lspconfigs.gopls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = { gopls = { analyses = { unusedparams = true }, staticcheck = true, gofumpt = true } },
      })
    end,

    -- eslint
    ["eslint"] = function()
      lspconfigs.eslint.setup({
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
        end,
        capabilities = capabilities,
      })
    end,
  })
else
  -- Fallback: manually configure each server from `servers` list
  for _, server_name in ipairs(servers) do
    local opts = { on_attach = on_attach, capabilities = capabilities }

    if server_name == "ts_ls" then
      opts.on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        on_attach(client, bufnr)
      end
      opts.settings = {
        typescript = { inlayHints = { includeInlayParameterNameHints = "all", includeInlayParameterNameHintsWhenArgumentMatchesName = false, includeInlayFunctionParameterTypeHints = true, includeInlayVariableTypeHints = true, includeInlayPropertyDeclarationTypeHints = true, includeInlayFunctionLikeReturnTypeHints = true, includeInlayEnumMemberValueHints = true } },
        javascript = { inlayHints = { includeInlayParameterNameHints = "all", includeInlayParameterNameHintsWhenArgumentMatchesName = false, includeInlayFunctionParameterTypeHints = true, includeInlayVariableTypeHints = true, includeInlayPropertyDeclarationTypeHints = true, includeInlayFunctionLikeReturnTypeHints = true, includeInlayEnumMemberValueHints = true } },
      }
    elseif server_name == "lua_ls" then
      opts.settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
          telemetry = { enable = false },
          format = { enable = false },
        },
      }
    elseif server_name == "gopls" then
      opts.settings = { gopls = { analyses = { unusedparams = true }, staticcheck = true, gofumpt = true } }
    end

    local configs = require("lspconfig.configs")
    local server_mod = configs[server_name]
    if not server_mod then
      local ok, config = pcall(require, "lspconfig.configs." .. server_name)
      if ok and config then
        server_mod = config
        configs[server_name] = config
      end
    end
    if server_mod and type(server_mod.setup) == "function" then
      server_mod.setup(opts)
    end
  end
end
