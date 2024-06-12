return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter.configs")

    config.setup({
      -- ensure_installed = {"lua", "javascript", "typescript", "go", "java", "kotlin", "rust", "html", "css", "json"},
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
