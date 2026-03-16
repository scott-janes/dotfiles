-- ============================================================================
-- Plugin Configuration - Lazy.nvim plugin specs
-- ============================================================================
-- This file defines all plugins and their configurations

return require("lazy").setup({
  -- Essential dependencies
  { "nvim-lua/plenary.nvim", lazy = true },

  -- UI: Theme (tokyonight moon)
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("yolomcswaggins.ui.theme")
    end,
  },

  -- UI: Icons (load early so other UI plugins can use icons/fallbacks)
  {
    "nvim-tree/nvim-web-devicons",
    lazy = false,
    config = function()
      require("nvim-web-devicons").setup({ default = true })
    end,
  },

  -- UI: Mini modules (icons etc.) used by some UI plugins (noice views)
  {
    "echasnovski/mini.nvim",
    lazy = true,
    event = "VeryLazy",
    config = function()
      local ok, icons = pcall(require, "mini.icons")
      if ok and icons and type(icons.setup) == "function" then
        pcall(icons.setup, {})
      end
    end,
  },

  -- UI: Centered cmdline (noice + nui)
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("yolomcswaggins.ui.noice")
    end,
  },

  -- UI: Statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      require("yolomcswaggins.ui.statusline")
    end,
  },

  -- UI: Which-key (keybinding menu)
  {
    "folke/which-key.nvim",
    -- Load which-key eagerly so its `operators` and registration run before
    -- other plugins create mappings. This reduces spurious "old spec"
    -- and overlapping-key warnings during startup.
    lazy = false,
    priority = 1100,
    config = function()
      local wk = require("which-key")
      wk.setup({
        -- Use `defer` to avoid showing the popup immediately for operator
        -- prefixes like `gc`. Returning true tells which-key to wait for the
        -- next keypress (so `<gc>` won't trigger the popup and conflict with
        -- a concrete mapping like `<gcc>`).
        defer = function(ctx)
          if ctx.operator and type(ctx.operator) == "string" then
            -- Defer for the comment operator `gc` (and other `g`-prefixed ops if
            -- desired). This keeps operator usage smooth while removing the
            -- overlap warning from which-key.
            if ctx.operator == "gc" or ctx.operator:match("^g") then
              return true
            end
          end
          -- Also defer in visual block modes if desired
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

      -- Register leader key groups using explicit full-key mappings. This
      -- format matches which-key's suggested spec so healthcheck won't warn
      -- about using an old mapping format.
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

      -- Register comment mappings as descriptions only (no remaps). This tells
      -- which-key about the operator `gc` and the concrete mapping `gcc`,
      -- which removes the overlap warning while leaving Comment.nvim in
      -- control of the actual mappings.
      wk.add({
        { "<gc>", group = "Comment (operator)", mode = { "n", "o", "x" } },
        { "<gcc>", "Toggle comment line", desc = "Toggle comment line", mode = { "n", "o", "x" } },
      }, { version = 2 })

      -- Note: we intentionally do not register a top-level `gc` mapping here.
      -- Comment.nvim provides `gc` (operator) and `gcc` (line toggle). We use
      -- `defer` above so which-key will wait for the next key when an operator
      -- like `gc` is started — that prevents the `<gc>` vs `<gcc>` overlap
      -- warning while avoiding creating conflicting mappings.
    end,
  },

  -- File Explorer: Neo-tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle file explorer" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("yolomcswaggins.tools.neo-tree")
    end,
  },

  -- Fuzzy Finder: Telescope
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
      { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
      { "<leader>fr", "<cmd>Telescope resume<cr>", desc = "Resume last search" },
    },
    config = function()
      require("yolomcswaggins.tools.telescope")
    end,
  },

  -- Welcome dashboard (alpha.nvim)
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("yolomcswaggins.ui.dashboard")
    end,
  },

  -- Official GitHub Copilot plugin
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("yolomcswaggins.tools.copilot")
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = true,
  },

  -- Harpoon: Quick file navigation
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ha", function() require("harpoon"):list():add() end, desc = "Add file to harpoon" },
      { "<leader>hh", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "Toggle harpoon menu" },
      { "<leader>h1", function() require("harpoon"):list():select(1) end, desc = "Harpoon file 1" },
      { "<leader>h2", function() require("harpoon"):list():select(2) end, desc = "Harpoon file 2" },
      { "<leader>h3", function() require("harpoon"):list():select(3) end, desc = "Harpoon file 3" },
      { "<leader>h4", function() require("harpoon"):list():select(4) end, desc = "Harpoon file 4" },
    },
    config = function()
      require("yolomcswaggins.tools.harpoon")
    end,
  },

  -- Lazygit integration
  {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit", "LazyGitConfig", "LazyGitCurrentFile", "LazyGitFilter", "LazyGitFilterCurrentFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Open LazyGit" },
    },
    config = function()
      require("yolomcswaggins.tools.lazygit")
    end,
  },

  -- Git signs in gutter
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local wk = require("which-key")
          -- Register buffer-local git mappings using the modern which-key spec.
          wk.add({
            { "<leader>g", group = "Git" },
            { "<leader>gb", function() gs.blame_line({ full = true }) end, desc = "Git blame line" },
            { "<leader>gp", gs.preview_hunk, desc = "Preview hunk" },
            { "<leader>gr", gs.reset_hunk, desc = "Reset hunk" },
            { "<leader>gs", gs.stage_hunk, desc = "Stage hunk" },
            { "<leader>gu", gs.undo_stage_hunk, desc = "Undo stage hunk" },
          }, { buffer = bufnr, version = 2 })
        end,
      })
    end,
  },

  -- Treesitter: Syntax highlighting & more
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      -- Some tree-sitter installs expose a different module name; prefer the
      -- plugin's public entry so modules load regardless of naming differences.
      local ts = require("nvim-treesitter")
      ts.setup({
        ensure_installed = {
          "lua",
          "vim",
          "vimdoc",
          "typescript",
          "javascript",
          "tsx",
          "go",
          "json",
          "yaml",
          "markdown",
          "markdown_inline",
          "bash",
          "regex",
        },
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
        },
      })
    end,
  },

  -- Rainbow brackets
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local rainbow_delimiters = require("rainbow-delimiters")
      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }
    end,
  },

  -- LSP: Mason (LSP installer)
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },

  -- LSP: Mason + nvim-lspconfig bridge
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("yolomcswaggins.lang.lsp")
    end,
  },

  -- TypeScript native tools (pmizio/typescript-tools.nvim)
  {
    "pmizio/typescript-tools.nvim",
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    config = function()
      -- minimal setup; lsp attach and capabilities are handled centrally in lsp.lua
      require("typescript-tools").setup({})
    end,
  },

  -- LSP: Core configuration
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      { "folke/lazydev.nvim", ft = "lua", opts = {} }, -- Better Lua LSP for Neovim config
    },
  },

  -- Debugging: (disabled) nvim-dap and related plugins removed

  -- Completion: nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            -- Prioritize nvim-cmp menu, then luasnip, then Copilot via copilot#Accept, then fallback
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              -- Try Copilot accept (call via lua -> vim.fn)
              local cop_ok, cop_ret = pcall(vim.fn['copilot#Accept'], "\"")
              if cop_ok and cop_ret and cop_ret ~= "" then
                -- feed the returned keys
                vim.api.nvim_feedkeys(cop_ret, 'i', true)
              else
                fallback()
              end
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
          { name = "lazydev", group_index = 0 },
          { name = "copilot" }, -- Copilot via copilot-cmp
        }),
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        formatting = {
          format = function(entry, vim_item)
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
              copilot = "[Copilot]",
              lazydev = "[Lua]",
            })[entry.source.name]
            return vim_item
          end,
        },
        sorting = {
          priority_weight = 2,
          comparators = {
            -- deprioritize copilot entries so LSP/snippets come first
            function(entry1, entry2)
              local s1 = entry1.source.name
              local s2 = entry2.source.name
              if s1 == "copilot" and s2 ~= "copilot" then
                return false
              end
              if s2 == "copilot" and s1 ~= "copilot" then
                return true
              end
            end,
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
      })
    end,
  },

  -- Formatting: conform.nvim
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>gf",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = { "n", "v" },
        desc = "Format buffer",
      },
    },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          javascript = { "prettierd", "prettier", stop_after_first = true },
          typescript = { "prettierd", "prettier", stop_after_first = true },
          javascriptreact = { "prettierd", "prettier", stop_after_first = true },
          typescriptreact = { "prettierd", "prettier", stop_after_first = true },
          json = { "prettierd", "prettier", stop_after_first = true },
          yaml = { "prettierd", "prettier", stop_after_first = true },
          markdown = { "prettierd", "prettier", stop_after_first = true },
          go = { "gofumpt", "goimports" },
          terraform = { "terraform_fmt" },
          tf = { "terraform_fmt" },
        },
        default_format_opts = {
          lsp_format = "fallback",
        },
        format_on_save = nil, -- Disabled: use <leader>gf instead
      })
    end,
  },

  -- Additional language support
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("yolomcswaggins.lang.go")
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
  },
}, {
  ui = {
    border = "rounded",
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
