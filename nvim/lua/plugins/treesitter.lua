local M = {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	dependencies = {
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
			event = "VeryLazy",
		},
		{
			"JoosepAlviste/nvim-ts-context-commentstring",
			event = "VeryLazy",
			config = function() require("ts_context_commentstring").setup() end,
		},
		{
			"windwp/nvim-ts-autotag",
			event = "VeryLazy",
			config = function() require("nvim-ts-autotag").setup() end,
		},
	},
}

function M.config()
	require("nvim-treesitter").setup({
		install_dir = vim.fn.stdpath("data") .. "/site",
	})

	-- Install parsers
	require("nvim-treesitter").install({
		"lua",
		"typescript",
		"markdown",
		"markdown_inline",
		"bash",
		"python",
		"java",
		"html",
		"yaml",
	})

	-- Enable treesitter highlighting and folding for all filetypes
	vim.api.nvim_create_autocmd("FileType", {
		callback = function() pcall(vim.treesitter.start) end,
	})

	-- Textobjects config (main branch: keymaps must be set manually)
	local ok, ts_textobjects = pcall(require, "nvim-treesitter-textobjects")
	if not ok then return end

	ts_textobjects.setup({
		select = {
			lookahead = true,
		},
	})

	local select_keymaps = {
		["af"] = "@function.outer",
		["if"] = "@function.inner",
		["at"] = "@class.outer",
		["it"] = "@class.inner",
		["ac"] = "@call.outer",
		["ic"] = "@call.inner",
		["aa"] = "@parameter.outer",
		["ia"] = "@parameter.inner",
		["al"] = "@loop.outer",
		["il"] = "@loop.inner",
		["ai"] = "@conditional.outer",
		["ii"] = "@conditional.inner",
		["a/"] = "@comment.outer",
		["i/"] = "@comment.inner",
		["ab"] = "@block.outer",
		["ib"] = "@block.inner",
		["as"] = "@statement.outer",
		["is"] = "@statement.inner",
		["aA"] = "@attribute.outer",
		["iA"] = "@attribute.inner",
		["aF"] = "@frame.outer",
		["iF"] = "@frame.inner",
	}

	local select = require("nvim-treesitter-textobjects.select")
	for key, query in pairs(select_keymaps) do
		vim.keymap.set({ "x", "o" }, key, function() select.select_textobject(query, "textobjects") end, { desc = query })
	end
end

return M
