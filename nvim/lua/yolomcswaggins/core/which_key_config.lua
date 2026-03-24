-- Full which-key.nvim setup and registration logic
vim.g.which_key_check_health = 0
local M = {}

function M.which_key_setup()
  local wk = require("which-key")
  wk.setup({
    defer = function(ctx)
      if ctx.operator and type(ctx.operator) == "string" then
        if ctx.operator == "gc" or ctx.operator:match("^g") then
          return true
        end
      end
      return ctx.mode == "V" or ctx.mode == "<C-V>"
    end,
    preset = "modern",
    delay = 300,
    plugins = {
      presets = {
        operators = true,
        motions = true,
        text_objects = true,
        windows = true,
        nav = true,
        z = true,
        g = true,
      },
    },
  })

  -- Register leader key groups using explicit full-key mappings.
  wk.add({
    { "<leader>f", group = "Find" },
    { "<leader>g", group = "Git" },
    { "<leader>l", group = "LSP" },
    { "<leader>h", group = "Harpoon" },
    { "<leader>b", group = "Buffer" },
    { "<leader>w", group = "Window" },
    { "<leader>c", group = "Copilot" },
    { "<leader>ca", ":Copilot panel<CR>", desc = "Copilot panel" },
    { "<leader>cs", ":Copilot setup<CR>", desc = "Copilot setup" },
  }, { version = 2 })

  -- Register comment mappings as descriptions only (no remaps).
  -- Do not register <gc> or <gcc> with which-key to keep popup clean and avoid overlap noise.


  -- Note: No top-level `gc` mapping here; defer and Comment.nvim handle registration.
end

return M
