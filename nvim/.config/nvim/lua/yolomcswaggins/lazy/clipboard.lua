return {
	{
		"AckslD/nvim-neoclip.lua",
		dependencies = {
			{ "kkharji/sqlite.lua", module = "sqlite" },
			"nvim-telescope/telescope.nvim",
			"ibhagwan/fzf-lua",
		},
		config = function()
			require("neoclip").setup({
				enable_macro_history = true,
				enable_persistent_history = true,
			})
			vim.keymap.set("n", "<leader>hh", ":Telescope neoclip plus<CR>", { desc = "neoclip" })
		end,
	},
}
