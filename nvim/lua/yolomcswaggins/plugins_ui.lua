-- UI plugins
table.insert = table.insert

return {
  -- Theme (tokyonight moon)
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("yolomcswaggins.ui.theme")
    end,
  },
  -- Icons
  {
    "nvim-tree/nvim-web-devicons",
    lazy = false,
    config = function()
      require("nvim-web-devicons").setup({ default = true })
    end,
  },
  -- Mini (for icons/UI modules for noice, etc.)
  {
    "echasnovski/mini.nvim",
    lazy = true,
    event = "VeryLazy",
    config = function()
      local ok, icons = pcall(require, "mini.icons")
      if ok and icons and type(icons.setup) == "function" then
        pcall(icons.setup, {})
      end
    end,
  },
  -- Noice (centered cmdline)
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("yolomcswaggins.ui.noice")
    end,
  },
  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      require("yolomcswaggins.ui.statusline")
    end,
  },
  -- Which-key (keybinding menu)
  {
    "folke/which-key.nvim",
    lazy = false,
    priority = 1100,
    config = function() require("yolomcswaggins.core.which_key_config").which_key_setup() end,
  },
  -- Welcome Dashboard (alpha.nvim)
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("yolomcswaggins.ui.dashboard")
    end,
  },
}