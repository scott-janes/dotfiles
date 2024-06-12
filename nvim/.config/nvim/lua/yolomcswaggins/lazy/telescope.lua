return  {
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.6',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'norlock/nvim-traveller-buffers',
    },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set('n', '<C-p>', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      local traveller_buffers = require('nvim-traveller-buffers')
      vim.keymap.set('n', '<leader>b', traveller_buffers.buffers, {desc = 'Browse buffers'})

    end
  },
  {
    'nvim-telescope/telescope-ui-select.nvim',
    config = function()

      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
            }
          },
        }
      })
      require("telescope").load_extension("ui-select")
    end
  },
}

