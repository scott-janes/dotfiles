local constants = require("constants")
local colors = require("colors")

local spaces = {}

local swapWatcher = sbar.add("item", {
    drawing = false,
    updates = true,
})

local currentWorkspaceWatcher = sbar.add("item", {
    drawing = false,
    updates = true,
})

local spaceConfigs <const> = {
    ["Y"] = { icon = "Y", name = "Browsing", color = colors.cmap_1 },
    ["U"] = { icon = "U", name = "Coding", color = colors.cmap_2 },
    ["I"] = { icon = "I", name = "Random", color = colors.cmap_3 },
    ["O"] = { icon = "O", name = "Random", color = colors.cmap_4 },
    ["P"] = { icon = "P", name = "Music", color = colors.cmap_5 },
    ["qt"] = { icon = "'", name = "Misc", color = colors.cmap_6 },
    ["sc"] = { icon = ";", name = "Misc", color = colors.cmap_7 },
    ["bs"] = { icon = "/", name = "Chat", color = colors.cmap_8 },
}

local function selectCurrentWorkspace(focusedWorkspaceName)
    for sid, item in pairs(spaces) do
        if item ~= nil then
            local isSelected = sid == constants.items.SPACES .. "." .. focusedWorkspaceName

            local itemName = sid:match("([^%.]+)$")
            local spaceConfig = spaceConfigs[itemName]
            item:set({
                icon = { color = isSelected and colors.tn_black3 or spaceConfig.color },
                label = {
                    color = isSelected and colors.tn_black3 or spaceConfig.color,
                    width = isSelected and "dynamic" or 0,
                },
                background = {
                    color = isSelected and spaceConfig.color or colors.transparent,
                    border_color = spaceConfig.color,
                },
            })
        end
    end

    sbar.trigger(constants.events.UPDATE_WINDOWS)
end

local function findAndSelectCurrentWorkspace()
    sbar.exec(constants.aerospace.GET_CURRENT_WORKSPACE, function(focusedWorkspaceOutput)
        local focusedWorkspaceName = focusedWorkspaceOutput:match("[^\r\n]+")
        selectCurrentWorkspace(focusedWorkspaceName)
    end)
end

local function addWorkspaceItem(workspace)
    local parsedWorkspace = {}
    for key, value in string.gmatch(workspace, "(%w+)=([%w%s()]+)") do
        parsedWorkspace[key] = value
    end
    local workspaceName = parsedWorkspace["workspaceName"]
    local monitorName = parsedWorkspace["workspaceMonitor"]
    local spaceName = constants.items.SPACES .. "." .. workspaceName
    local spaceConfig = spaceConfigs[workspaceName]

    spaces[spaceName] = sbar.add("item", spaceName, {
        associated_display = constants.displays[monitorName],
        label = {
            width = 0,
            padding_left = 0,
            string = spaceConfig.name or "meow",
        },
        icon = {
            string = spaceConfig.icon or "?",
            color = spaceConfig.color or colors.red,
            padding_left = 8,
            padding_right = 8,
        },
        background = {
            color = colors.transparent,
        },
        padding_right = 0,
        padding_left = 0,
        click_script = "aerospace workspace " .. workspaceName,
    })

    spaces[spaceName]:subscribe("mouse.entered", function(env)
        sbar.animate("tanh", 30, function()
            spaces[spaceName]:set({ label = { width = "dynamic" } })
        end)
    end)

    spaces[spaceName]:subscribe("mouse.exited", function(env)
        sbar.animate("tanh", 30, function()
            spaces[spaceName]:set({ label = { width = 0 } })
        end)
    end)

    sbar.add("item", spaceName .. ".padding", {
        width = 8,
    })
end

local orderList = { "Y", "U", "I", "O", "P", "sl", "bs", "qt", "sc" }
local function createWorkspaces()
    sbar.exec(constants.aerospace.LIST_ALL_WORKSPACES_AND_MONITORS, function(workspacesOutput)
        local workspacesByName = {}
        for workspace in workspacesOutput:gmatch("[^\r\n]+") do
            local workspaceName = workspace:match("workspaceName=([%w%s]+)")
            workspacesByName[workspaceName] = workspace
        end

        local orderedToOrder = {}
        for _, key in ipairs(orderList) do
            if workspacesByName[key] then
                table.insert(orderedToOrder, workspacesByName[key])
            end
        end

        -- Process orderedToOrder
        for _, workspace in ipairs(orderedToOrder) do
            addWorkspaceItem(workspace) -- Or whatever processing you need
        end

        findAndSelectCurrentWorkspace()
    end)
end

swapWatcher:subscribe(constants.events.SWAP_MENU_AND_SPACES, function(env)
    local isShowingSpaces = env.isShowingMenu == "off" and true or false
    sbar.set("/" .. constants.items.SPACES .. "\\..*/", { drawing = isShowingSpaces })
end)

currentWorkspaceWatcher:subscribe(constants.events.AEROSPACE_WORKSPACE_CHANGED, function(env)
    selectCurrentWorkspace(env.FOCUSED_WORKSPACE)
    sbar.trigger(constants.events.UPDATE_WINDOWS)
end)

createWorkspaces()
