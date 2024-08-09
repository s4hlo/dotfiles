local M = {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"nvim-lua/plenary.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
}

function M.config()
	require("mason").setup({
		ui = {
			border = "rounded",
		},
	})
	require("mason-lspconfig").setup({
		automatic_installation = true,
		ensure_installed = {
			"lua_ls",
			"html",
			"tsserver",
			"pyright",
			"marksman",
			"tailwindcss",
      "jsonls"
		},
	})
	require("mason-tool-installer").setup({
		ensure_installed = {
			"black",
			"stylua",
			"shfmt",
			"isort",
			"tree-sitter-cli",
			"jupytext",
		},
	})
end

return M
