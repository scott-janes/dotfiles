return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      theme = 'tokyonight'
    }
  },

  config = function(PluginSpec, opts)
    require("lualine").setup(opts)
  end
}
