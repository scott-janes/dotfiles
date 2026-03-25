-- ============================================================================
-- UI: Noice Configuration - Centered cmdline & enhanced UI
-- ============================================================================

require("noice").setup({
  cmdline = { enabled = true, view = "cmdline_popup" },
  messages = { enabled = true },
  routes = {
    {
      filter = { error = true },
      view = "notify",
      opts = { stop = false },
    },
  },
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
    signature = { enabled = false },
  },
  views = {
    notify = {
      backend = "notify",
      max_height = 8,
      timeout = 5000,
    },
  },
  presets = {
    bottom_search = false,
    command_palette = true,
    long_message_to_split = true,
    inc_rename = false,
    lsp_doc_border = true,
  },
})

-- Configure nvim-notify
require("notify").setup({
  background_colour = "#000000",
  fps = 30,
  icons = {
    DEBUG = "",
    ERROR = "",
    INFO = "",
    TRACE = "✎",
    WARN = "",
  },
  level = 2,
  minimum_width = 50,
  render = "default",
  stages = "fade_in_slide_out",
  timeout = 5000,
  top_down = true,
  max_height = 8,
})
