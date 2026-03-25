-- Test tooling and debug plugins for neotest, Jest, Go, and DAP
-- Add to Lazy.nvim specs in plugins.lua

return {
  -- Debugger plugins (DAP, Go, JS/TS, UI)
  {
    "ldelossa/nvim-dap-projects",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("nvim-dap-projects").search_project_config()
    end,
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      local wk_ok, wk = pcall(require, "which-key")
      if wk_ok then
        wk.add({
          { "<leader>d", group = "+debug (DAP)" },
          { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
          { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Conditional breakpoint" },
          { "<leader>dc", function() require("dap").continue() end, desc = "Continue/start debug" },
          { "<leader>do", function() require("dap").step_over() end, desc = "Step over" },
          { "<leader>di", function() require("dap").step_into() end, desc = "Step into" },
          { "<leader>dO", function() require("dap").step_out() end, desc = "Step out" },
          { "<leader>dx", function() require("dap").terminate() end, desc = "Terminate debugging" },
          { "<leader>dr", function() require("dap").repl.open() end, desc = "Open REPL" },
          { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle DAP UI" },
          { "<leader>dl", function() require("dap").run_last() end, desc = "Run last debug" },
          { "<leader>de", function() require("dapui").eval() end, desc = "Evaluate expression" },
-- Debug nearest test (context-aware): Go uses nvim-dap-go, JS uses neotest DAP
            { "<leader>dt", function()
                local ft = vim.bo.filetype
                if ft == "go" then
                  require("dap-go").debug_test()
                elseif ft == "typescript" or ft == "javascript" or ft == "typescriptreact" or ft == "javascriptreact" then
                  require("neotest").run.run({ strategy = "dap" })
                else
                  vim.notify("No nearest test debug for this filetype")
                end
              end, desc = "Debug nearest test (Go/neotest)" },
        }, { version = 2 })
      end

      -- Register pwa-node debug adapter
      local dap = require("dap")
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "127.0.0.1",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            os.getenv("HOME") .. "/vscode-js-debug/dist/src/dapDebugServer.js",
            "${port}"
          }
        }
      }
    end,
  },

  -- snacks.nvim for beautiful select/input popups
  {
    "folke/snacks.nvim",
    opts = {
      picker = {},
      explorer = {},
    }
  },

  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    config = function()
      require("mason-nvim-dap").setup({
        ensure_installed = { "delve" },
        automatic_installation = true,
        handlers = {},
      })
    end,
  },
  {
    "leoluz/nvim-dap-go",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("dap-go").setup()
    end,
    ft = "go",
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup()
      dap.listeners.before.attach.dapui_config = function() dapui.open() end
      dap.listeners.before.launch.dapui_config = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
      dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
    end,
  },
  -- Core neotest framework + config
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/nvim-nio",
    },
    lazy = false,
    config = function()
      local ok, neotest = pcall(require, "neotest")
      if not ok then return end
      neotest.setup({
        adapters = {
          require("neotest-go")({
            recursive_run = true,
            args = { "-count=1", "-timeout=60s" },
          }),
require("neotest-jest")({
  cwd = function()
    return vim.loop.cwd()
  end,
  -- Optional: Remove jestCommand unless you really need a wrapper (defaults to local jest)
  -- jestCommand = "npx jest",
  isTestFile = function(file_path)
    return file_path and (file_path:match("%.spec%.ts$") or file_path:match("%.test%.ts$"))
  end,
  strategy_config = function()
    return {
      type = "pwa-node",
      request = "launch",
      name = "Debug Jest Test",
      runtimeArgs = {
        "--inspect-brk",
        "node_modules/.bin/jest",
        "--runInBand"
      },
      skipFiles = { "<node_internals>/**", "node_modules/**" },
      console = "integratedTerminal",
      env = { NODE_OPTIONS = "--no-warnings" }
    }
  end,
  jest_test_discovery = false,
}),
        },
      })
      local ok2, wk = pcall(require, "which-key")
      if ok2 then
        wk.add({
{ "<leader>t", group = "+test (neotest)" },
           { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Show output panel" },
           { "<leader>ta", function() require("neotest").run.attach() end, desc = "Attach debugger" },
           { "<leader>td", function() require("neotest").run.run(vim.fn.getcwd()) end, desc = "Run all in dir" },
           { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run file tests" },
           { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle summary" },
           { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle output pane" },
           { "<leader>tt", function() require("neotest").run.run() end, desc = "Run nearest test" },
           { "<leader>dt", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug nearest test (neotest)" },
           { "<leader>tx", function() require("neotest").run.stop() end, desc = "Stop test" },
        }, { version = 2 })
      end
    end,
  },
  {
    "nvim-neotest/neotest-jest",
    dependencies = { "nvim-neotest/neotest" },
    lazy = false,
  },
  {
    "nvim-neotest/neotest-go",
    dependencies = { "nvim-neotest/neotest" },
    lazy = false,
  },
}
