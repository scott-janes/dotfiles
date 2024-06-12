return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    style = "moon"
  },
  config = function(PluginSpec, opts)
    require("tokyonight").setup(opts)
    vim.cmd.colorscheme "tokyonight"
  end
} 
