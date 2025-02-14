return {
  "nvim-neorg/neorg",
  lazy = false,
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "luarocks.nvim",
    "nvim-neorg/neorg-telescope",
  },
  config = function()
    require("neorg").setup({
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
        ["core.completion"] = {
          config = {
            engine = "nvim-cmp",
          }
        },
        ["core.highlights"] = {},
        ["core.integrations.treesitter"] = {
          config = {
            install_parsers = true,
            configure_parsers = true,
          }
        },
        ["core.integrations.telescope"] = {
          config = {
            insert_file_link = {
              show_title_preview = true
            }
          }
        },
        ["core.dirman"] = {
          config = {
            workspaces = {
              notes = "~/git/personal/notes"
            },
            default_workspace = "notes",
          },
        },
      },
    })
  end,

}
