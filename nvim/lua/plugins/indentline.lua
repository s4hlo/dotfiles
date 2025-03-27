-- local N = {
--   "lukas-reineke/indent-blankline.nvim",
--   event = "VeryLazy",
-- }

local M = { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} }

local highlight = {
	"RainbowBlue",
	"RainbowYellow",
	"RainbowRed",
	"RainbowOrange",
	"RainbowGreen",
	"RainbowViolet",
	"RainbowCyan",
}

function M.config()
	local icons = require("user.icons")
	local colors = require("user.colors")

	local hooks = require("ibl.hooks")
	-- create the highlight groups in the highlight setup hook, so they are reset
	-- every time the colorscheme changes
	hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
		vim.api.nvim_set_hl(0, "RainbowBlue", { fg = colors.blue })
		vim.api.nvim_set_hl(0, "RainbowYellow", { fg = colors.yellow })
		vim.api.nvim_set_hl(0, "RainbowRed", { fg = colors.red })
		vim.api.nvim_set_hl(0, "RainbowOrange", { fg = colors.orange })
		vim.api.nvim_set_hl(0, "RainbowGreen", { fg = colors.green })
		vim.api.nvim_set_hl(0, "RainbowViolet", { fg = colors.purple })
		vim.api.nvim_set_hl(0, "RainbowCyan", { fg = colors.cyan })
	end)

	require("ibl").setup({
		indent = {
			-- char = icons.ui.LineLeft,
			char = icons.ui.LineMiddle,
		},
		exclude = {
			filetypes = {
				"python",
				"quarto",
				"help",
				"startify",
				"dashboard",
				"lazy",
				"neogitstatus",
				"Trouble",
				"text",
			},
			buftypes = {
				"terminal",
				"nofile",
			},
		},
		scope = {
			injected_languages = false,
			enabled = true,
			show_end = false,
			show_start = false,
			highlight = highlight,
		},
	})
end

return M
