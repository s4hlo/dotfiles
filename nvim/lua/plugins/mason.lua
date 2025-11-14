local M = {
	"williamboman/mason-lspconfig.nvim",
	event = { "BufReadPre", "BufNewFile" },
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
			border = "rounded",
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
			"stylua",
			"shfmt",
			"tree-sitter-cli",
		},
	})
end

return M
