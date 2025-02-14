return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "tsserver",
          "jdtls",
          "tailwindcss",
          "jsonls",
          "gopls",
          "templ",
          "html",
          "htmx",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local set = vim.keymap.set
      local opts = { noremap = true, silent = true }
      set("n", "<leader>e", vim.diagnostic.open_float, opts)
      set("n", "[d", vim.diagnostic.goto_prev, opts)
      set("n", "]d", vim.diagnostic.goto_next, opts)
      set("n", "<leader>q", vim.diagnostic.setloclist, opts)
      local lspconfig = require("lspconfig")
      local on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = { noremap = true, buffer = bufnr }
        set("n", "gD", vim.lsp.buf.declaration, bufopts)
        set("n", "gd", vim.lsp.buf.definition, bufopts)
        set("n", "K", vim.lsp.buf.hover, bufopts)
        set("n", "<leader>li", vim.lsp.buf.implementation, bufopts)
        set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
        set("n", "<leader>ld", vim.lsp.buf.type_definition, bufopts)
        set("n", "<leader>lr", vim.lsp.buf.rename, bufopts)
        set("n", "<leader>la", vim.lsp.buf.code_action, bufopts)
        set("n", "gr", vim.lsp.buf.references, bufopts)
        set("n", "<leader>=", vim.lsp.buf.formatting_sync, bufopts)
      end
      lspconfig.html.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "html", "templ" },
      })
      lspconfig.htmx.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "html", "templ" },
      })

      lspconfig.tailwindcss.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "templ", "astro", "javascript", "typescript", "react" },
        settings = {
          tailwindCSS = {
            includeLanguages = {
              templ = "html",
            },
          },
        },
      })

      local servers = { "gopls", "lua_ls", "tsserver", "jdtls", "jsonls", "templ" }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end
      -- lspconfig.gopls.setup({
      --   on_attach = on_attach,
      --   capabilities = capabilities,
      -- })
      -- lspconfig.lua_ls.setup({
      --   on_attach = on_attach,
      --   capabilities = capabilities,
      -- })
      -- lspconfig.tsserver.setup({
      --   on_attach = on_attach,
      --   capabilities = capabilities,
      -- })
      -- lspconfig.jdtls.setup({
      --   on_attach = on_attach,
      --   capabilities = capabilities,
      -- })
      -- lspconfig.tailwindcss.setup({
      --   on_attach = on_attach,
      --   capabilities = capabilities,
      -- })
      -- lspconfig.jsonls.setup({
      --   on_attach = on_attach,
      --   capabilities = capabilities,
      -- })
    end,
  },
}
