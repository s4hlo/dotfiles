return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			require("tokyonight").setup({
				on_colors = function(c)
					c.border = c.blue0
				end,
				style = "night",
				-- on_colors = function(colors)
				-- 	colors.border = "#565f89"
				-- end,
			})
			vim.cmd.colorscheme("tokyonight-night")
		end,
	},
}
