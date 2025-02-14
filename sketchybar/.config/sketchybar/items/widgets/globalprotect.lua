--globalprotect.lua
local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

local is_on = false

local globalprotect_icon = sbar.add("item", "widgets.globalprotect", {
    position = "right",
    padding_right = 0,
    icon = {
        -- string = icons.wifi.router,
        string = icons.network,
        width = 0,
        align = "left",
        font = {
            style = settings.font.style_map["Regular"],
            size = 16.0,
        },
        color = colors.orange,
    },
    update_freq = 180,
    label = {
        width = 30,
        align = "left",
        font = {
            style = settings.font.style_map["Regular"],
            size = 14.0,
        },
        color = colors.orange,
    },
})

local globalprotect_bracket = sbar.add("bracket", "widgets.globalprotect.bracket", {
    globalprotect_icon.name,
}, {
    background = {
        color = colors.bg1,
        border_color = colors.orange,
        border_width = colors.border_width,
    },
    popup = { align = "center" },
})

sbar.add("item", "widgets.globalprotect.padding", {
    position = "right",
    width = settings.group_paddings,
})

local function runScript()
    os.execute([[
        osascript -e '
            tell application "System Events" to tell process "GlobalProtect"
                click menu bar item 1 of menu bar 2 -- Activates the GlobalProtect "window" in the menubar
                set frontmost to true -- keep window 1 active
                tell window 1
                    -- Click on the connect or disconnect button, depending on if they exist or not
                    if exists (first UI element whose title is "Connect") then
                        tell (first UI element whose title is "Connect") to if exists then click
                    else
                        tell (first UI element whose title is "Disconnect") to if exists then click
                    end if
                end tell
                click menu bar item 1 of menu bar 2 -- This will close the GlobalProtect "window" after clicking Connect/Disconnect. This is optional.
            end tell
        '
    ]])
end

local function setColors(color)
    globalprotect_icon:set({
        icon = { color = color },
        background = { border_color = color },
    })
    globalprotect_bracket:set({
        background = { border_color = color },
    })
end

local function switchOff()
    runScript()
    is_on = false
    globalprotect_icon:set({
        icon = { color = colors.orange },
        background = { border_color = colors.orange },
    })
    globalprotect_bracket:set({
        background = { border_color = colors.orange },
    })
end

local function switchOn()
    runScript()
    is_on = true
    globalprotect_icon:set({
        icon = { color = colors.red },
    })
    globalprotect_bracket:set({
        background = { border_color = colors.red },
    })
end

local function toggleGlobalProtectConnection(env)
    if is_on == true then
        switchOff()
    else
        switchOn()
    end
end

local function check_vpn_status(env)
    local vpn_target = os.getenv("VPN_TARGET")
    local handle = io.popen("ping -c 1 -W 2 " .. vpn_target .. " > /dev/null 2>&1; echo $?")
    local result = handle:read("*a")
    handle:close()

    is_on = tonumber(result) == 0
    local color = is_on and colors.green or colors.red
    setColors(color)
end

globalprotect_icon:subscribe({ "forced", "routine", "system_woke" }, check_vpn_status)


globalprotect_icon:subscribe("mouse.clicked", toggleGlobalProtectConnection)
