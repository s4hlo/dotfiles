local M = {
	"nvim-lualine/lualine.nvim",
	commit = "7533b0ead663d80452210c0c089e5105089697e5",
	dependencies = {
		{ "AndreM222/copilot-lualine" },
	},
}

function M.config()
	local sl_hl = vim.api.nvim_get_hl_by_name("StatusLine", true)

	local theme = function()
		local colors = {
			blue = nil,
			green = nil,
			purple = nil,
			cyan = nil,
			red1 = nil,
			red2 = "#be5046",
			yellow = nil,
			bg = nil,
			fg = "#282c34",
			gray1 = nil,
			gray2 = nil,
			gray3 = nil,
		}

		-- local colors = {
		--   blue = "#61afef",
		--   green = "#98c379",
		--   purple = "#c678dd",
		--   cyan = "#56b6c2",
		--   red1 = "#e06c75",
		--   red2 = "#be5046",
		--   yellow = "#e5c07b",
		--   fg = "#abb2bf",
		--   bg = "#282c34",
		--   gray1 = "#828997",
		--   gray2 = nil,
		--   gray3 = "#3e4452",
		-- }

		return {
			normal = {
				a = { fg = colors.bg, bg = colors.green, gui = "bold" },
				b = { fg = colors.fg, bg = colors.gray3 },
				c = { fg = colors.red2, bg = colors.gray2 },
			},
			command = { a = { fg = colors.bg, bg = colors.yellow, gui = "bold" } },
			insert = { a = { fg = colors.bg, bg = colors.blue, gui = "bold" } },
			visual = { a = { fg = colors.bg, bg = colors.purple, gui = "bold" } },
			terminal = { a = { fg = colors.bg, bg = colors.cyan, gui = "bold" } },
			replace = { a = { fg = colors.bg, bg = colors.red1, gui = "bold" } },
			inactive = {
				a = { fg = colors.gray1, bg = colors.bg, gui = "bold" },
				b = { fg = colors.gray1, bg = colors.bg },
				c = { fg = colors.gray1, bg = colors.gray2 },
			},
		}
	end

	local isRecording = function()
		local reg = vim.fn.reg_recording()
		if reg == "" then
			return ""
		end -- not recording
		return "[  " .. reg .. "]"
	end

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

		-- sections = {
		--   lualine_a = { "mode" },
		--   lualine_b = { "filename" },
		--   lualine_c = { "diff" },
		--   lualine_x = {
		--     "diagnostics",
		--   },
		--   lualine_y = {
		--     { "filetype", icon_only = true },
		--     {
		--       "copilot",
		--       show_colors = true,
		--     },
		--   },
		--   lualine_z = { "progress" },
		-- },

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
				{
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
								enabled = "#50FA7B",
								sleep = "#AEB7D0",
								disabled = "#6272A4",
								warning = "#FFB86C",
								unknown = "#FF5555",
							},
						},
						spinners = require("copilot-lualine.spinners").dots,
						spinner_color = "#6272A4",
					},
					show_colors = true,
					show_loading = true,
				},
			},

			lualine_x = { "diagnostics" },
			lualine_y = {},
			lualine_z = {},
		},
		extensions = { "quickfix", "man", "fugitive", "neo-tree", "lazy" },
	})
end

return M
