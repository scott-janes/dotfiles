-- ============================================================================
-- Plugin Configuration - Modularized (Lazy.nvim plugin specs)
-- ============================================================================
-- Now requires all plugin groups and merges them for lazy.nvim setup

local plugins = {}

for _, group in ipairs({
  require("yolomcswaggins.plugins_ui"),
  require("yolomcswaggins.plugins_tools"),
  require("yolomcswaggins.plugins_lsp"),
  require("yolomcswaggins.plugins_completion"),
  require("yolomcswaggins.plugins_format"),
}) do
  for _, plugin in ipairs(group) do
    table.insert(plugins, plugin)
  end
end

return require("lazy").setup(plugins, {
  ui = { border = "rounded" },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
