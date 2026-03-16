local wezterm = require("wezterm")
local config = {}
config.font = wezterm.font("Monaspace Neon")
config.font_size = 16
config.color_scheme = "Tokyo Night Moon"
local function basename(s)
    return s and s:match("([^/\\]+)$") or ""
end
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    local pane = tab.active_pane
    local dir = pane.current_working_dir and pane.current_working_dir:match("([^/\\]+)$") or ""
    return " " .. dir .. " "
end)
return config
