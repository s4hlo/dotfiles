local M = {
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			-- Only one of these is needed.
			"nvim-telescope/telescope.nvim", -- optional
			"ibhagwan/fzf-lua", -- optional
			"echasnovski/mini.pick", -- optional
			-- "folke/snacks.nvim", -- optional
		},
	},
	{ "akinsho/git-conflict.nvim", version = "*", config = true },
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

function M.get_keys()
	return {
		{ "<leader>g", group = "Git" },
		{ "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>", desc = "Next Hunk", mode = "n" },
		{ "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>", desc = "Prev Hunk", mode = "n" },
		{ "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>", desc = "Blame", mode = "n" },
		{ "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", desc = "Preview Hunk", mode = "n" },
		{ "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", desc = "Reset Hunk", mode = "n" },
		{ "<leader>gS", "<cmd>lua require 'gitsigns'.stage_buffer()<cr>", desc = "Stage Buffer", mode = "n" },
		{ "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", desc = "Reset Buffer", mode = "n" },
		{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview", mode = "n" },

		{ "<leader>gc", group = "Conflict" },
		{ "<leader>gco", "<cmd>GitConflictChooseOurs<cr>", desc = "Choose Ours", mode = "n" },
		{ "<leader>gct", "<cmd>GitConflictChooseTheirs<cr>", desc = "Choose Theirs", mode = "n" },
		{ "<leader>gcb", "<cmd>GitConflictChooseBoth<cr>", desc = "Choose Both", mode = "n" },
		{ "<leader>gcN", "<cmd>GitConflictChooseNone<cr>", desc = "Choose None", mode = "n" },
		{ "<leader>gcn", "<cmd>GitConflictNextConflict<cr>", desc = "Next Conflict", mode = "n" },
		{ "<leader>gcp", "<cmd>GitConflictPrevConflict<cr>", desc = "Prev Conflict", mode = "n" },
	}
end

return M
