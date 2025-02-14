local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

local battery = sbar.add("item", "widgets.battery", {
  position = "right",
  icon = {
    font = {
      style = settings.font.style_map["Regular"],
      size = 19.0,
    },
  },
  label = { font = { family = settings.font.numbers }, color = colors.tn_orange },
  update_freq = 180,
  popup = {
    align = "center",
    background = { color = colors.tn_black3, border_color = colors.tn_orange, border_width = 2 },
  },
})

local remaining_time = sbar.add("item", {
  position = "popup." .. battery.name,
  icon = {
    string = "Time remaining:",
    width = 100,
    align = "left",
  },
  label = {
    string = "??:??h",
    width = 100,
    align = "right",
  },
})

local battery_bracket = sbar.add("bracket", "widgets.battery.bracket", { battery.name }, {
	background = { color = colors.tn_black3, border_color = colors.tn_orange },
})

battery:subscribe({ "routine", "power_source_change", "system_woke" }, function()
  sbar.exec("pmset -g batt", function(batt_info)
    local icon = "!"
    local label = "?"

    local found, _, charge = batt_info:find("(%d+)%%")
    if found then
      charge = tonumber(charge)
      label = charge .. "%"
    end

    local color = colors.tn_green
    local charging, _, _ = batt_info:find("AC Power")

    if charging then
      icon = icons.battery.charging
    else
      if found and charge > 80 then
        icon = icons.battery._100
      elseif found and charge > 60 then
        icon = icons.battery._75
      elseif found and charge > 40 then
        icon = icons.battery._50
      elseif found and charge > 20 then
        icon = icons.battery._25
        color = colors.tn_orange
      else
        icon = icons.battery._0
        color = colors.tn_red
      end
    end

    local lead = ""
    if found and charge < 10 then
      lead = "0"
    end

    battery:set({
      icon = {
        string = icon,
        color = color,
      },
      label = { string = lead .. label, color = color },
    })

    battery_bracket:set({ background = { border_color = color } })
  end)
end)

battery:subscribe("mouse.clicked", function(env)
  local drawing = battery:query().popup.drawing
  battery:set({ popup = { drawing = "toggle" } })

  if drawing == "off" then
    sbar.exec("pmset -g batt", function(batt_info)
      local found, _, remaining = batt_info:find(" (%d+:%d+) remaining")
      local label = found and remaining .. "h" or "No estimate"
      remaining_time:set({ label = label })
    end)
  end
end)

sbar.add("item", "widgets.battery.padding", {
  position = "right",
  width = settings.group_paddings,
})
