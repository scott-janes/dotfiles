local settings = require("settings")
local app_icons = require("helpers.app_icons")
local colors = require("colors")

local apps = { "Slack", "Microsoft Outlook", "Discord" }

local function get_status_label(app_name)
    local find_command = 'lsappinfo find LSDisplayName="' .. app_name .. '" 2>/dev/null'
    local app_id = io.popen(find_command):read("*line")
    if not app_id then
        return nil
    end

    local info_command = "lsappinfo info -only StatusLabel " .. app_id .. " 2>/dev/null"
    local status_label = io.popen(info_command):read("*line")

    if status_label then
        local label_value = string.match(status_label, 'label"="([^"]*)"')
        if label_value and label_value ~= "" then
            return label_value
        end
    end
    return nil
end

local notifcationWatcher = sbar.add("item", {
    drawing = false,
    updates = true,
    update_freq = 30,
    padding_left = 0,
    padding_right = 0,
})

local function update_notifications()
    for _, app_name in ipairs(apps) do
        local status_label = get_status_label(app_name) or ""

        if status_label and status_label ~= "" then
            local icon = app_icons[app_name] or app_icons["default"]
            sbar.add("item", app_name, {
                associated_display = 1,
                position = "right",
                icon = {
                    string = icon,
                    font = settings.font.icons(),
                    color = colors.neon_purple2,
                },
            })
        else
            print("removing " .. app_name)
            sbar.remove(app_name)
        end
    end
end

notifcationWatcher:subscribe({ "forced", "routine", "system_woke" }, update_notifications)
