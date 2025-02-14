local constants = require("constants")
local colors    = require("colors")
local icons     = require("icons")

sbar.add("event", constants.events.SWAP_MENU_AND_SPACES)

local function switchToggle(menuToggle)
    local isShowingMenu = menuToggle:query().icon.value == icons.switch.on

    menuToggle:set({
        icon = isShowingMenu and icons.switch.off or icons.switch.on,
        label = isShowingMenu and "Menus" or "Spaces",
    })

    sbar.trigger(constants.events.SWAP_MENU_AND_SPACES, { isShowingMenu = isShowingMenu })
end

local function addToggle()
    local menuToggle = sbar.add("item", constants.items.MENU_TOGGLE, {
        icon = {
            string = icons.switch.on,
            color = colors.neon_purple2,
            padding_left = 6,
            padding_right = 8,
        },
        label = {
            width = 0,
            color = colors.neon_purple2,
            string = "Spaces",
            padding_right = 8
        },
        background = {
            color = colors.transparent,
            border_color = colors.neon_purple2,
        },
        padding_left = 0,
        padding_right = 0,
    })

    sbar.add("item", constants.items.MENU_TOGGLE .. ".padding", {
        width = 8
    })

    menuToggle:subscribe("mouse.entered", function(env)
        sbar.animate("tanh", 30, function()
            menuToggle:set({
                background = {
                    color = { alpha = 1.0 },
                    border_color = { alpha = 0.5 },
                },
                icon = { color = colors.neon_purple2 },
                label = { width = "dynamic" }
            })
        end)
    end)

    menuToggle:subscribe("mouse.exited", function(env)
        sbar.animate("tanh", 30, function()
            menuToggle:set({
                background = {
                    color = { alpha = 0.0 },
                    border_color = { alpha = 0.0 },
                },
                icon = { color = colors.neon_purple1 },
                label = { width = 0 }
            })
        end)
    end)

    menuToggle:subscribe("mouse.clicked", function(env)
        switchToggle(menuToggle)
    end)

    menuToggle:subscribe(constants.events.AEROSPACE_SWITCH, function(env)
        switchToggle(menuToggle)
    end)
end

addToggle()
