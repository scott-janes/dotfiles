local alpha_ok, alpha = pcall(require, "alpha")
if not alpha_ok then
  return
end
local dashboard = require("alpha.themes.dashboard")

-- Header (compact ASCII art)
dashboard.section.header.val = {
  [[    ___       __   __  __           __        ]],
  [[   / _ \___  / /__/ /_/ /  ___ ___/ /__  ___ ]],
  [[  / , _/ _ \/ / _  / _  /__/ -_) _  / _ \/ _ \]],
  [[ /_/|_|\___/_/\_,_/\_,_/\___/\_,_/\___/_//_/]],
}

-- Buttons with devicons-aware fallbacks (fixes missing-glyph issues on some fonts)
local devicons_ok, devicons = pcall(require, "nvim-web-devicons")
local function icon_or(pref, ext, ascii)
  if devicons_ok and type(devicons.get_icon) == "function" then
    local ico = devicons.get_icon("", ext)
    if ico and ico ~= "" then
      return ico .. "  "
    end
  end
  return (pref or ascii) .. "  "
end

dashboard.section.buttons.val = {
  dashboard.button("n", icon_or("", "txt", "[N]") .. "New file", ":ene <BAR> startinsert<CR>"),
  dashboard.button("f", icon_or("", "txt", "[F]") .. "Find file", ":Telescope find_files<CR>"),
  dashboard.button("r", icon_or("", "txt", "[R]") .. "Recent files", ":Telescope oldfiles<CR>"),
  dashboard.button("p", icon_or("", "lua", "[P]") .. "Plugins", ":Lazy<CR>"),
  dashboard.button("e", icon_or("", "folder", "[E]") .. "Explorer", ":Neotree toggle<CR>"),
  dashboard.button("h", icon_or("", "lua", "[H]") .. "Harpoon", ":lua require('harpoon.ui').toggle_quick_menu()<CR>"),
  -- Open a normal buffer first, enter insert, then open Copilot after a short delay
  dashboard.button("c", "  Copilot", 
    ":lua (function() vim.cmd('ene') vim.cmd('startinsert') vim.defer_fn(function() vim.cmd('Copilot') end, 150) end)()<CR>"
  ),
}

-- Footer
dashboard.section.footer.val = { "⚡ Have fun — Press 'c' for Copilot, 'n' to create a file" }

alpha.setup(dashboard.opts)
