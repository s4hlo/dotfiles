local M = {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		{ "AndreM222/copilot-lualine" },
	},
}

function M.config()
	local colors = require("user.colors")

	local theme_cache = nil
	local theme = function()
		if theme_cache == nil then
			theme_cache = {
				normal = {
					a = { fg = nil, bg = nil, gui = "bold" },
					b = { fg = colors.background, bg = nil },
					c = { fg = nil, bg = nil },
				},
				command = { a = { fg = nil, bg = nil, gui = "bold" } },
				insert = { a = { fg = nil, bg = nil, gui = "bold" } },
				visual = { a = { fg = nil, bg = nil, gui = "bold" } },
				terminal = { a = { fg = nil, bg = nil, gui = "bold" } },
				replace = { a = { fg = nil, bg = nil, gui = "bold" } },
				inactive = {
					a = { fg = nil, bg = nil, gui = "bold" },
					b = { fg = nil, bg = nil },
					c = { fg = nil, bg = nil },
				},
			}
		end
		return theme_cache
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
					enabled = "",
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

	local _sections = {
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
		}

	require("lualine").setup({
		options = {
			theme = theme(),
			component_separators = { left = "", right = "-" },
			section_separators = { left = "", right = "" },

			always_divide_middle = true, -- When set to true, left sections i.e. 'a','b' and 'c'
			-- can't take over the entire statusline even
			-- if neither of 'x', 'y' or 'z' are present.

			ignore_focus = {},
		},

		sections = _sections,

		extensions = { "quickfix", "man", "fugitive", "neo-tree", "lazy" },
	})
end

return M
