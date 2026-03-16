local M = {}

require("copilot").setup({
  panel = { enabled = true },
  suggestion = {
    enabled = true,
    auto_trigger = true,
    keymap = {
      accept = "<M-]>",
      accept_word = false,
      accept_line = false,
      next = "<M-;>",
      prev = "<M-,>",
      dismiss = "<C-]>",
    },
  },
  filetypes = { ["*"] = true },
  copilot_node_command = "node",
})

-- copilot-cmp adapter will handle cmp source registration

return M
