-- ============================================================================
-- Language: Go Configuration - Additional Go tooling
-- ============================================================================

require("go").setup({
  -- Disable formatting on save (use conform.nvim with <leader>gf instead)
  lsp_cfg = false, -- Don't override gopls setup (handled in lsp.lua)
  lsp_gofumpt = true,
  lsp_on_attach = false, -- Use common on_attach from lsp.lua
  dap_debug = false, -- Disable DAP for now
  dap_debug_gui = false,
  test_runner = "go", -- Use 'go test' command
  run_in_floaterm = false,
  textobjects = true,
  icons = { breakpoint = "🔴", currentpos = "🔶" },
  verbose = false,
  log_path = vim.fn.expand("$HOME") .. "/tmp/gonvim.log",
  lsp_document_formatting = false,
  lsp_inlay_hints = {
    enable = true,
  },
  trouble = false,
  test_efm = false,
})

-- Go-specific keybindings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    local wk = require("which-key")
    wk.add({
      { "<leader>g", group = "Go" },
      { "<leader>gt", group = "Test" },
      { "<leader>gtt", "<cmd>GoTest<cr>", desc = "Run tests" },
      { "<leader>gtf", "<cmd>GoTestFunc<cr>", desc = "Test function" },
      { "<leader>gtp", "<cmd>GoTestPkg<cr>", desc = "Test package" },
      { "<leader>gc", "<cmd>GoCoverage<cr>", desc = "Coverage" },
      { "<leader>gi", "<cmd>GoImplements<cr>", desc = "Show implements" },
      { "<leader>ge", "<cmd>GoIfErr<cr>", desc = "Add if err" },
      { "<leader>gfs", "<cmd>GoFillStruct<cr>", desc = "Fill struct" },
    }, { buffer = 0, version = 2 })
  end,
})
