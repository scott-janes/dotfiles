local icons = require("icons")
local colors = require("colors")
local settings = require("settings")
local constants = require("constants")

local monitorName = "C49RG9x"

-- Execute the event provider binary which provides the event "cpu_update" for
-- the cpu load data, which is fired every 2.0 seconds.
sbar.exec("killall cpu_load >/dev/null; $CONFIG_DIR/helpers/event_providers/cpu_load/bin/cpu_load cpu_update 2.0")

local cpu = sbar.add("graph", "widgets.cpu", 42, {
  associated_display = constants.displays[monitorName],
  position = "right",
  graph = { color = colors.accent1 },
  background = {
    height = 22,
    color = { alpha = 0 },
    border_color = { alpha = 0 },
    drawing = true,
  },
  icon = { string = icons.cpu },
  label = {
    -- string = "cpu ??%",
    font = {
      family = settings.font.numbers,
      style = settings.font.style_map["Bold"],
      size = 9.0,
    },
    align = "right",
    padding_right = 0,
    width = 0,
    y_offset = 4,
  },
  padding_right = settings.paddings + 6,
})

local cpu_bracket = sbar.add("bracket", "widgets.cpu.bracket", { cpu.name }, {
  background = { color = colors.tn_black3, border_color = colors.blue },
})

cpu:subscribe("cpu_update", function(env)
  -- Also available: env.user_load, env.sys_load
  local load = tonumber(env.total_load)
  cpu:push({ load / 150. })
  local alpha = 0.4
  local color = colors.tn_blue
  local fill_color = colors.with_alpha(color, alpha)
  if load > 30 then
    if load < 60 then
      color = colors.tn_yellow
      fill_color = colors.with_alpha(color, alpha)
    elseif load < 80 then
      color = colors.tn_orange
      fill_color = colors.with_alpha(color, alpha)
    else
      color = colors.tn_red
      fill_color = colors.with_alpha(color, alpha)
    end
  end

  cpu:set({
    graph = { color = color, fill_color = fill_color },
    label = { string = env.total_load .. "%", color = color },
    icon = {
      color = color,
    },
  })

  cpu_bracket:set({ background = { border_color = color } })
end)

cpu:subscribe("mouse.clicked", function(env)
  sbar.exec("open -a 'Activity Monitor'")
end)

-- Background around the cpu item
sbar.add("item", "widgets.cpu.padding", {
  position = "right",
  width = settings.group_paddings,
})
