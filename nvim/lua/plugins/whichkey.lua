local neotree_key = {
	{ "<C-p>", "<cmd>Telescope find_files hidden=true<cr>", desc = "Find File", mode = "n" },
	{ "<A-f>", "<cmd>Telescope live_grep<cr>", desc = "Find Text", mode = "n" },
	{ "<A-e>", "<cmd>Neotree reveal toggle filesystem<CR>", desc = "Explorer", mode = "n" },
	{ "<leader>e", "<cmd>Neotree reveal toggle filesystem<CR>", desc = "Explorer", mode = "n" },
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
		{ "<leader>e", "<cmd>Neotree reveal toggle filesystem<CR>", desc = "Explorer", mode = "n" },
		{ "ZR", ufo.openAllFolds, desc = "Open all folds", mode = "n" },
		{ "ZM", ufo.closeAllFolds, desc = "Close all folds", mode = "n" },
	}

	local telescope_plugin = require("plugins.telescope")
	local find_keys = telescope_plugin.get_keys()

	local http_plugin = require("plugins.http")
	local kulala_keys = http_plugin.get_keys()

	local git_plugin = require("plugins.git")
	local git_keys = git_plugin.get_keys()

	local lsp_plugins = require("plugins.lspconfig")
	local lsp_keys = lsp_plugins[1].get_keys()

	which_key.add(misc)

	which_key.add(find_keys)
	which_key.add(lsp_keys)
	which_key.add(kulala_keys)
	which_key.add(git_keys)
end

return M
