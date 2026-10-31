local M = {
	"williamboman/mason-lspconfig.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
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
		automatic_enable = false, -- lspconfig.lua enables servers
		ensure_installed = require("plugins.lspconfig")[1].servers,
	})
	require("mason-tool-installer").setup({
		ensure_installed = {
			"stylua",
			"shfmt",
			"tree-sitter-cli",
			"prettierd",
			"prettier",
		},
	})
end

return M
