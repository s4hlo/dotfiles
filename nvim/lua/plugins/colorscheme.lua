return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			vim.cmd.colorscheme("tokyonight-night")
			require("tokyonight").setup({
				style = "night",
				-- on_colors = function(colors)
				-- 	colors.border = "#565f89"
				-- end,
			})
		end,
	},
}
