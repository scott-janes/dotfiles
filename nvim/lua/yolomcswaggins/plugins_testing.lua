-- Test tooling plugins and adapters for neotest, Jest, and Go
-- Add to Lazy.nvim specs in plugins.lua

return {
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
            jestCommand = "npx jest",
            jestConfigFile = function(file)
              -- Use custom logic if needed, else let neotest-jest auto-detect
              if file:find("/packages/") then
                local match = file:match("(.*/[^/]+/)src")
                if match then return match .. "jest.config.ts" end
              end
              return nil
            end,
            cwd = function(file)
              if file:find("/packages/") then
                local match = file:match("(.*/[^/]+/)src")
                if match then return match end
              end
              return nil
            end,
            jest_test_discovery = false,
          })
        },
      })
      -- Which-key test runner mappings
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
  { "<leader>tx", function() require("neotest").run.stop() end, desc = "Stop test" },
}, { version = 2 })
      end
    end,
  },
  -- Jest/TS/JS adapter for neotest
  {
    "nvim-neotest/neotest-jest",
    dependencies = { "nvim-neotest/neotest" },
    lazy = false,
  },
  -- Go adapter for neotest
  {
    "nvim-neotest/neotest-go",
    dependencies = { "nvim-neotest/neotest" },
    lazy = false,
  },
}
