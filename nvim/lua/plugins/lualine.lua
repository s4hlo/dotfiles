local M = {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		{ "AndreM222/copilot-lualine" },
	},
}

function M.config()
	local colors = require("user.colors")

	local theme = function()
		local colors_lualine = {
			blue = nil,
			green = nil,
			purple = nil,
			cyan = nil,
			red1 = nil,
			red2 = colors.red,
			yellow = nil,
			bg = nil,
			fg = colors.background,
			gray1 = nil,
			gray2 = nil,
			gray3 = nil,
		}

		local colors_lualine_alt_ = {
			blue = colors.blue,
			green = colors.green,
			purple = colors.purple,
			cyan = colors.cyan,
			red1 = colors.red,
			red2 = colors.red,
			yellow = colors.yellow,
			fg = colors.white,
			bg = colors.surface,
			gray1 = colors.surface2,
			gray2 = nil,
			gray3 = colors.surface,
		}

		return {
			normal = {
				a = { fg = colors_lualine.bg, bg = colors_lualine.green, gui = "bold" },
				b = { fg = colors_lualine.fg, bg = colors_lualine.gray3 },
				c = { fg = colors_lualine.red2, bg = colors_lualine.gray2 },
			},
			command = { a = { fg = colors_lualine.bg, bg = colors_lualine.yellow, gui = "bold" } },
			insert = { a = { fg = colors_lualine.bg, bg = colors_lualine.blue, gui = "bold" } },
			visual = { a = { fg = colors_lualine.bg, bg = colors_lualine.purple, gui = "bold" } },
			terminal = { a = { fg = colors_lualine.bg, bg = colors_lualine.cyan, gui = "bold" } },
			replace = { a = { fg = colors_lualine.bg, bg = colors_lualine.red1, gui = "bold" } },
			inactive = {
				a = { fg = colors_lualine.gray1, bg = colors_lualine.bg, gui = "bold" },
				b = { fg = colors_lualine.gray1, bg = colors_lualine.bg },
				c = { fg = colors_lualine.gray1, bg = colors_lualine.gray2 },
			},
		}
	end

	local isRecording = function()
		local reg = vim.fn.reg_recording()
		if reg == "" then return "" end -- not recording
		return "[  " .. reg .. "]"
	end

	local copilotStatus = {
		"copilot",
		-- Default values
		symbols = {
			status = {
				icons = {
					enabled = " ",
					sleep = " ", -- auto-trigger disabled
					disabled = " ",
					warning = " ",
					unknown = " ",
				},
				hl = {
					enabled = colors.green,
					sleep = colors.white,
					disabled = colors.maroon,
					warning = colors.orange,
					unknown = colors.red,
				},
			},
			spinners = require("copilot-lualine.spinners").dots,
			spinner_color = colors.green,
		},
		show_colors = true,
		show_loading = true,
	}

	require("lualine").setup({
		options = {
			theme = theme(),
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },

			always_divide_middle = true, -- When set to true, left sections i.e. 'a','b' and 'c'
			-- can't take over the entire statusline even
			-- if neither of 'x', 'y' or 'z' are present.

			ignore_focus = {},
		},

		--minimal
		sections = {
			lualine_a = {
				{ "filetype", icon_only = true },
				{
					"filename",
					file_status = true, -- Displays file status (readonly status, modified status)
					newfile_status = false, -- Display new file status (new file means no write after created)
					path = 0, -- 0: Just the filename
					-- 1: Relative path
					-- 2: Absolute path
					-- 3: Absolute path, with tilde as the home directory
					-- 4: Filename and parent dir, with tilde as the home directory

					shorting_target = 40, -- Shortens path to leave 40 spaces in the window
					-- for other components. (terrible name, any suggestions?)
					symbols = {
						modified = "", -- Text to show when the file is modified.
						readonly = "", -- Text to show when the file is non-modifiable or readonly.
						unnamed = "[No Name]", -- Text to show for unnamed buffers.
						newfile = "*", -- Text to show for newly created file before first write
					},
				},
			},
			lualine_b = { "diff" },
			lualine_c = {
				isRecording,
				copilotStatus,
			},

			lualine_x = { "diagnostics" },
			lualine_y = {},
			lualine_z = {},
		},
		extensions = { "quickfix", "man", "fugitive", "neo-tree", "lazy" },
	})
end

return M
