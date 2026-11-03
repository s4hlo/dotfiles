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
					-- VS Code-style diff colors. The theme paints DiffChange red on both
					-- sides; diffview remaps these per side (see plugins/git.lua)
					DiffAdd = { bg = "#373D29" }, -- added line (green)
					DiffAddText = { bg = "#4B5632" }, -- added chars inside a changed line
					DiffDelete = { bg = "#4B1818" }, -- removed line (red)
					DiffDeleteText = { bg = "#6F1313" }, -- removed chars inside a changed line
					DiffChange = { bg = "#232a33" }, -- neutral for plain :diffthis
					DiffText = { bg = "#264F78" },
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
