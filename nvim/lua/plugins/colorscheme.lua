local M = {
	"navarasu/onedark.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("onedark").setup({
			style = "cool",
		})
		vim.cmd.colorscheme("tokyonight-night")
	end,
}

local N = {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {},
}

local O = { "catppuccin/nvim", name = "catppuccin", priority = 1000 }

return { M, N, O }
