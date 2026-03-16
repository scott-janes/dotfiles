-- ============================================================================
-- UI: Theme Configuration - Tokyo Night Moon
-- ============================================================================

require("tokyonight").setup({
  style = "moon", -- Tokyo Night Moon variant
  transparent = false,
  terminal_colors = true,
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    functions = {},
    variables = {},
    sidebars = "dark",
    floats = "dark",
  },
  sidebars = { "qf", "help", "terminal", "packer" },
  day_brightness = 0.3,
  hide_inactive_statusline = false,
  dim_inactive = false,
  lualine_bold = true,

  on_colors = function(colors)
    -- Customize colors if needed
  end,
  on_highlights = function(highlights, colors)
    -- Customize highlights if needed
  end,
})

-- Apply the colorscheme
vim.cmd([[colorscheme tokyonight-moon]])
