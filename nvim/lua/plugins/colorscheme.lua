return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = true,
		priority = 100,
		opts = {},
	},
	{
		"maxmx03/solarized.nvim",
		name = "solarized",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function() vim.cmd.colorscheme("solarized") end,
	},
}
