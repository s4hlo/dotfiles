local M = {
	"nvim-lualine/lualine.nvim",
	commit = "7533b0ead663d80452210c0c089e5105089697e5",
}

function M.config()
	local sl_hl = vim.api.nvim_get_hl_by_name("StatusLine", true)
	vim.api.nvim_set_hl(0, "Copilot", { fg = "#6CC644", bg = "#3e4452" })
	local icons = require("user.icons")
	local diff = {
		"diff",
		colored = true,
		symbols = { added = icons.git.LineAdded, modified = icons.git.LineModified, removed = icons.git.LineRemoved }, -- Changes the symbols used by the diff.
	}

	local copilot = function()
		local buf_clients = vim.lsp.get_active_clients({ bufnr = 0 })
		if #buf_clients == 0 then
			return "LSP Inactive"
		end

		local buf_client_names = {}
		local copilot_active = false

		for _, client in pairs(buf_clients) do
			if client.name ~= "null-ls" and client.name ~= "copilot" then
				table.insert(buf_client_names, client.name)
			end

			if client.name == "copilot" then
				copilot_active = true
			end
		end

		if copilot_active then
			return "%#Copilot#" .. ""
		end
		return ""
	end
	local theme = function()
		local colors = {
			blue = "#61afef",
			green = "#98c379",
			purple = "#c678dd",
			cyan = "#56b6c2",
			red1 = "#e06c75",
			red2 = "#be5046",
			yellow = "#e5c07b",
			fg = "#abb2bf",
			bg = "#282c34",
			gray1 = "#828997",
			gray2 = nil,
			gray3 = "#3e4452",
		}

		return {
			normal = {
				a = { fg = colors.bg, bg = colors.green, gui = "bold" },
				b = { fg = colors.fg, bg = colors.gray3 },
				c = { fg = colors.fg, bg = colors.gray2 },
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

	require("lualine").setup({
		options = {
			theme = theme(),
			-- theme = custom_onedark,
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			-- component_separators = { left = "", right = "" },
			-- section_separators = { left = "", right = "" },

			always_divide_middle = true, -- When set to true, left sections i.e. 'a','b' and 'c'
			-- can't take over the entire statusline even
			-- if neither of 'x', 'y' or 'z' are present.

			ignore_focus = { "NvimTree" },
		},

		sections = {
			-- lualine_a = { {"branch", icon =""} },
			-- lualine_b = { diff },
			-- lualine_c = { "diagnostics" },
			-- lualine_x = { copilot },
			-- lualine_y = { "filetype" },
			-- lualine_z = { "progress" },
			lualine_a = { "mode" },
			lualine_b = {
				{
					"buffers",
					show_filename_only = true, -- Shows shortened relative path when set to false.
					hide_filename_extension = false, -- Hide filename extension when set to true.
					show_modified_status = true, -- Shows indicator when the buffer is modified.

					mode = 2, -- 0: Shows buffer name
					-- 1: Shows buffer index
					-- 2: Shows buffer name + buffer index
					-- 3: Shows buffer number
					-- 4: Shows buffer name + buffer number

					-- max_length = vim.o.columns, -- Maximum width of buffers component,
					max_length = 180, -- Maximum width of buffers component,
					-- it can also be a function that returns
					-- the value of `max_length` dynamically.
					filetype_names = {
						TelescopePrompt = "Telescope",
						dashboard = "Dashboard",
						packer = "Packer",
						fzf = "FZF",
						alpha = "Alpha",
					}, -- Shows specific buffer name for that filetype ( { `filetype` = `buffer_name`, ... } )

					-- Automatically updates active buffer color to match color of other components (will be overidden if buffers_color is set)
					use_mode_colors = false,

					buffers_color = {
						-- Same values as the general color option can be used here.
						active = "lualine_b_normal", -- Color for active buffer.
						inactive = "lualine_b_inactive", -- Color for inactive buffer.
					},

					symbols = {
						modified = " ●", -- Text to show when the buffer is modified
						alternate_file = "", -- Text to show to identify the alternate file
						directory = "", -- Text to show when the buffer is a directory
					},
				},
			},
			lualine_c = {},

			lualine_x = {
				-- copilot,
				"diagnostics",
			},
			-- lualine_x = { "branch" },
			lualine_y = {
				copilot,
				{ "filetype", icon_only = true },
			},
			lualine_z = { "progress" },
		},
		extensions = { "quickfix", "man", "fugitive" },
	})
end

return M
