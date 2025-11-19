local neotree_key = {
		{ "<C-p>", "<cmd>Telescope find_files hidden=true<cr>", desc = "Find File", mode = "n" },
		{ "<A-f>", "<cmd>Telescope live_grep<cr>", desc = "Find Text", mode = "n" },
		{ "<A-e>", "<cmd>Neotree reveal toggle filesystem<CR>", desc = "Explorer", mode = "n" },
		{ "<A-g>", "<cmd>Telescope git_status<cr>", desc = "Open Changed File", mode = "n" },
		{ "<A-s>", "<cmd>Neotree float toggle document_symbols<CR>", desc = "Document Symbols", mode = "n" },
	}

local M = {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {},
	keys = neotree_key,
}


function M.config()
	local which_key = require("which-key")

	which_key.setup({
		triggers = {
			{ "<leader>", mode = { "n", "v" } },
			{ "z", mode = { "n", "v" } },
		},
		win = {
			border = "rounded",
		},
		disable = {
			buftypes = {},
			filetypes = { "TelescopePrompt" },
		},
	})
	local ufo = require("ufo")

	local misc = {
		{ "<leader>a", group = "AI", mode = { "n", "v" } },
		{ "ZR", ufo.openAllFolds, desc = "Open all folds", mode = "n" },
		{ "ZM", ufo.closeAllFolds, desc = "Close all folds", mode = "n" },
	}

	local find_keys = {
		{ "<leader>f", group = "Find" },
		{ "<leader>fb", "<cmd>Telescope buffers previewer=false<cr>", desc = "Buffers", mode = "n" },
		{ "<leader>fs", "<cmd>Telescope grep_string<cr>", desc = "Find String", mode = "n" },
		{ "<leader>fl", "<cmd>Telescope resume<cr>", desc = "Last Search", mode = "n" },
		{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent File", mode = "n" },
		{ "<leader>fR", "<cmd>Telescope registers<cr>", desc = "Registers", mode = "n" },
	}

	local lps_keys = {
		{ "<leader>l", group = "LSP", mode = { "n", "v" } },
		{ "<leader>lw", "<cmd>%s/\r//g<cr>", desc = "Remove ^M characters", mode = "v" },
		{ "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action", mode = "n" },
		{ "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename", mode = "n" },
		{ "<leader>lh", "<cmd>lua vim.diagnostic.open_float()<CR>", desc = "Diagnostics (float)", mode = "n" },
		{ "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<cr>", desc = "Next Diagnostic", mode = "n" },
		{ "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", desc = "Prev Diagnostic", mode = "n" },
		{ "<leader>ld", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics (telescope)", mode = "n" },
		{
			"<leader>lf",
			function()
				require("conform").format({
					async = false,
				})
			end,
			desc = "Format",
			mode = "n",
		},
	}

	local kulala = {
		{ "<leader>k", group = "Http" },
		{ "<leader>ks", "<cmd>lua require('kulala').run()<cr>", desc = "Send request", mode = { "n", "v" } },
		{ "<leader>ka", "<cmd>lua require('kulala').run_all()<cr>", desc = "Send all requests", mode = { "n", "v" }, ft = "http" },
		{ "<leader>kr", "<cmd>lua require('kulala').replay()<cr>", desc = "Replay the last request", ft = { "http", "rest" } },
		{ "<leader>ke", "<cmd>lua require('kulala').set_selected_env()<cr>", desc = "Replay the last request", ft = { "http", "rest" } },
	}

	local git_keys = {
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

	which_key.add(misc)

	which_key.add(find_keys)
	which_key.add(lps_keys)
	which_key.add(kulala)
	which_key.add(git_keys)
end

return M
