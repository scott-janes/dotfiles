return {
  text = "SF Pro",    -- Used for text
  numbers = "SF Mono", -- Used for numbers

  icons = function(size)
    local font = "sketchybar-app-font:Regular:"
    return size and font .. size or font .. 27
  end,

  -- Unified font style map
  style_map = {
    ["Regular"] = "Regular",
    ["Semibold"] = "Semibold",
    ["Bold"] = "Bold",
    ["Heavy"] = "Heavy",
    ["Black"] = "Black",
  },
}
