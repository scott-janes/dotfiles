return {
  "utilyre/barbecue.nvim",
  name = "barbecue",
  version = "*",
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons", -- optional dependency
  },
  opts = {
    theme = 'tokyonight'
  },

  config = function(PluginSpec, opts)
    require("barbecue").setup(opts)
  end
}

