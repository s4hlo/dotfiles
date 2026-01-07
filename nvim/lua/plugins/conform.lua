local M = {
	"stevearc/conform.nvim",
	opts = {},
}

function M.config()
	require("conform").setup({
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "black" },
			rust = { "rustfmt", lsp_format = "fallback" },
			javascript = { "prettierd", "prettier" },
			javascriptreact = { "prettierd", "prettier" },
			typescript = { "prettierd", "prettier" },
			typescriptreact = { "prettierd", "prettier" },
			json = { "prettierd", "prettier" },
			html = { "prettierd", "prettier" },
			css = { "prettierd", "prettier" },
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},
	})
end

return M
