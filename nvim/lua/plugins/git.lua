local M = {
	{
		"NeogitOrg/neogit",
		cmd = "Neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration
			"nvim-telescope/telescope.nvim", -- picker
		},
	},
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory", "DiffviewToggleFiles" },
		config = function()
			local close = { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } }
			local hooks = {}
			if require("user.theme") == "vscode" then
				-- VS Code look: old side red, new side green, filler lines dimmed
				local winhl = {
					a = "DiffAdd:DiffDelete,DiffChange:DiffDelete,DiffText:DiffDeleteText,DiffDelete:DiffviewDiffDeleteDim",
					b = "DiffChange:DiffAdd,DiffText:DiffAddText,DiffDelete:DiffviewDiffDeleteDim",
				}
				hooks.diff_buf_win_enter = function(_, winid, ctx)
					if ctx.layout_name:match("^diff2") and winhl[ctx.symbol] then
						vim.wo[winid].winhl = winhl[ctx.symbol]
					end
				end
			end
			require("diffview").setup({
				hooks = hooks,
				keymaps = {
					view = { close },
					file_panel = { close },
				},
			})
		end,
	},
	{ "akinsho/git-conflict.nvim", version = "*", event = { "BufReadPre", "BufNewFile" }, config = true },
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
		{ "<leader>gj", "<cmd>lua require 'gitsigns'.nav_hunk('next', {navigation_message = false})<cr>", desc = "Next Hunk", mode = "n" },
		{ "<leader>gk", "<cmd>lua require 'gitsigns'.nav_hunk('prev', {navigation_message = false})<cr>", desc = "Prev Hunk", mode = "n" },
		{ "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>", desc = "Blame", mode = "n" },
		{ "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", desc = "Preview Hunk", mode = "n" },
		{ "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", desc = "Reset Hunk", mode = "n" },
		{ "<leader>gS", "<cmd>lua require 'gitsigns'.stage_buffer()<cr>", desc = "Stage Buffer", mode = "n" },
		{ "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", desc = "Reset Buffer", mode = "n" },
		{
			"<leader>gd",
			function()
				if require("diffview.lib").get_current_view() then
					vim.cmd("DiffviewClose")
				else
					vim.cmd("DiffviewOpen")
				end
			end,
			desc = "Toggle Diffview",
			mode = "n",
		},

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
