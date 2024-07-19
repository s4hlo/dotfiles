local M = {
	"navarasu/onedark.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("onedark").setup({
			style = "cool",
		})
		vim.cmd.colorscheme("tokyonight")
	end,
}

local N = {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {},
}

return { M, N }
