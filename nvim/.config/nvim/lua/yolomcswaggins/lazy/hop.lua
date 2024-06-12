return {
  "smoka7/hop.nvim",
  config = function()
    require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
    vim.keymap.set("n", "<leader>j", ":HopWord<CR>" , {})
  end,
}
