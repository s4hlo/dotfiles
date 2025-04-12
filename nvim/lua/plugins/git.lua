return {
	{ "akinsho/git-conflict.nvim", version = "*", config = true },
	{
		"sindrets/diffview.nvim",
		config = function()
			local actions = require("diffview.actions")
			require("diffview").setup({
				diff_binaries = false, -- Show diffs for binaries
				enhanced_diff_hl = true, -- See |diffview-config-enhanced_diff_hl|
				git_cmd = { "git" }, -- The git executable followed by default args.
				hg_cmd = { "hg" }, -- The hg executable followed by default args.
				use_icons = true, -- Requires nvim-web-devicons
				show_help_hints = false, -- Show hints for how to open the help panel
				watch_index = true, -- Update views and index buffers when the git index changes.
				file_panel = {
					listing_style = "tree", -- One of 'list' or 'tree'
					tree_options = { -- Only applies when listing_style is 'tree'
						flatten_dirs = true, -- Flatten dirs that only contain one single dir
						folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
					},
					win_config = { -- See |diffview-config-win_config|
						position = "right",
						width = 35,
						win_opts = {},
					},
				},
				icons = { -- Only applies when use_icons is true.
					folder_closed = " ",
					folder_open = " ",
				},
				keymaps = {
					file_panel = {
						["gf"] = function()
							actions.goto_file_edit()
							vim.cmd("tabclose #")
						end,
						["q"] = function() vim.cmd("tabclose") end,
						["<leader>e"] = function() vim.cmd("DiffviewToggleFiles") end,
					},
				},
			})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "BufEnter",
		cmd = "Gitsigns",
		config = function()
			require("gitsigns").setup({
				watch_gitdir = {
					interval = 1000,
					follow_files = true,
				},
				attach_to_untracked = true,
				current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
				update_debounce = 200,
				max_file_length = 40000,
				preview_config = {
					border = "rounded",
					style = "minimal",
					relative = "cursor",
					row = 0,
					col = 1,
				},
			})
		end,
	},
}
