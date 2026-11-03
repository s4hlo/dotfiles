-- Switch themes in lua/user/theme.lua
local active = require("user.theme")

return {
	{
		-- Matches the Windows Terminal "Dark+" scheme (VS Code Dark+)
		"Mofiqul/vscode.nvim",
		name = "vscode",
		lazy = active ~= "vscode",
		priority = 1000,
		config = function()
			require("vscode").setup({
				style = "dark",
				transparent = true, -- let the terminal's #1E1E1E show through
				italic_comments = true,
				underline_links = true,
				group_overrides = {
					-- statusline (lualine) blends with the terminal background
					StatusLine = { fg = "#d4d4d4", bg = "NONE" },
					StatusLineNC = { fg = "#808080", bg = "NONE" },
				},
			})
			if active == "vscode" then vim.cmd.colorscheme("vscode") end
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = active ~= "catppuccin",
		priority = 1000,
		config = function()
			if active == "catppuccin" then vim.cmd.colorscheme("catppuccin-mocha") end
		end,
	},
}
