local constants = require("constants")
local settings = require("settings")
local colors = require("colors")
local app_icons = require("helpers.app_icons")

local frontApps = {}

sbar.add("bracket", constants.items.FRONT_APPS, {}, { position = "left" })

local frontAppWatcher = sbar.add("item", {
    drawing = false,
    updates = true,
    padding_left = 0,
    padding_right = 0,
})

local function selectFocusedWindow(focusedWindowId)
    for _, app in pairs(frontApps) do
        local isSelected = tonumber(app.windowId) == tonumber(focusedWindowId)
        local color = isSelected and colors.cmap_10 or colors.tn_white3
        app.item:set({
            label = { color = color },
            icon = { color = color },
        })
    end
end

local function updateWindows(windows)
    sbar.remove("/" .. constants.items.FRONT_APPS .. "\\.*/")

    frontApps = {}
    local foundWindows = string.gmatch(windows, "[^\n]+")
    for window in foundWindows do
        local parsedWindow = {}
        for key, value in string.gmatch(window, "(%w+)=([%w%s()]+)") do
            parsedWindow[key] = value
        end

        local windowId = parsedWindow["id"]
        local windowName = parsedWindow["name"]
        local monitorName = parsedWindow["monitor"]
        local icon = app_icons[windowName] or app_icons["default"]

        local itemId = constants.items.FRONT_APPS .. "." .. windowName .. "." .. windowId
        frontApps[windowId] = {
            item = sbar.add("item", itemId, {
                associated_display = constants.displays[monitorName],
                label = {
                    padding_left = 0,
                    padding_right = 0,
                },
                icon = {
                    string = icon,
                    font = settings.font.icons(),
                },
                click_script = "aerospace focus --window-id " .. windowId,
            }),
            windowId = windowId,
        }
    end

    sbar.exec(constants.aerospace.GET_CURRENT_WINDOW_ID, function(focusedWindowId)
        selectFocusedWindow(focusedWindowId)
    end)
    -- sbar.exec(constants.aerospace.GET_CURRENT_WINDOW, function(frontAppName)
    -- 	selectFocusedWindow(frontAppName:gsub("[\n\r]", ""))
    -- end)
end

local function getWindows()
    sbar.exec(constants.aerospace.LIST_WINDOWS, updateWindows)
end

frontAppWatcher:subscribe(constants.events.UPDATE_WINDOWS, function()
    getWindows()
end)

frontAppWatcher:subscribe(constants.events.FRONT_APP_SWITCHED, function(env)
    getWindows()
end)

getWindows()
