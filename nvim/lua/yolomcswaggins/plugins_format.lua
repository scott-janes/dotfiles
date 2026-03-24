-- Formatting plugin(s)
return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>gf",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = { "n", "v" },
        desc = "Format buffer",
      },
    },
    config = function()
      local constants = require("yolomcswaggins.constants")
      require("conform").setup({
        formatters_by_ft = constants.formatters_by_ft
      })
    end,
  },
}