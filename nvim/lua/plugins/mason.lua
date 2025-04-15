local M = {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"nvim-lua/plenary.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
}

-- is more assure install lsp, linter and formatter on demand, to avoid setup overload
function M.config()
	require("mason").setup({
		ui = {
			border = require("user.config").border,
		},
	})
	require("mason-lspconfig").setup({
		automatic_installation = true,
		ensure_installed = {
			"lua_ls",
			"html",
			"ts_ls",
			"bashls",
			"pyright",
			"marksman",
			"tailwindcss",
			"jsonls",
		},
	})
	require("mason-tool-installer").setup({
		ensure_installed = {
			-- "black",
			"stylua",
			"shfmt",
			-- "isort",
			"tree-sitter-cli",
			-- "jupytext",
		},
	})
end

return M
