local M = {
	"nvim-telescope/telescope.nvim",
	dependencies = { { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true } },
	lazy = true,
	cmd = "Telescope",
}

function M.config()
	local icons = require("user.icons")
	local actions = require("telescope.actions")

	require("telescope").setup({
		defaults = {
			prompt_prefix = icons.ui.Telescope .. " ",
			selection_caret = icons.ui.Forward .. " ",
			entry_prefix = "   ",
			initial_mode = "insert",
			selection_strategy = "reset",
			path_display = { "smart" },
			color_devicons = true,
			set_env = { ["COLORTERM"] = "truecolor" },
			sorting_strategy = nil,
			layout_strategy = nil,
			layout_config = {},
			vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				"--hidden",
				"--glob=!.git/",
				"--trim",
			},

			mappings = {
				i = {
					["<Down>"] = actions.cycle_history_next,
					["<Up>"] = actions.cycle_history_prev,
				},
				n = {
					["<esc>"] = actions.close,
					["j"] = actions.move_selection_next,
					["k"] = actions.move_selection_previous,
					["q"] = actions.close,
				},
			},
		},
		pickers = {
			find_files = {
				theme = "dropdown",
				previewer = false,
			},

			buffers = {
				theme = "dropdown",
				previewer = false,
				initial_mode = "normal",
				mappings = {
					i = {
						["<C-d>"] = actions.delete_buffer,
					},
					n = {
						["dd"] = actions.delete_buffer,
					},
				},
			},
			colorscheme = {
				enable_preview = true,
			},
		},
	})
end

function M.get_keys()
	return {
		{ "<leader>f", group = "Find" },
		{ "<leader>fb", "<cmd>Telescope buffers previewer=false<cr>", desc = "Buffers", mode = "n" },
		{ "<leader>fs", "<cmd>Telescope grep_string<cr>", desc = "Find String", mode = "n" },
		{ "<leader>fl", "<cmd>Telescope resume<cr>", desc = "Last Search", mode = "n" },
		{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent File", mode = "n" },
		{ "<leader>fR", "<cmd>Telescope registers<cr>", desc = "Registers", mode = "n" },
		{ "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics", mode = "n" },
	}
end

return M
