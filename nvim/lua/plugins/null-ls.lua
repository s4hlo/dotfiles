local M = {
	"nvimtools/none-ls.nvim",
}

local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
local event = "BufWritePre" -- or "BufWritePost"
local async = event == "BufWritePost"

function M.config()
	local null_ls = require("null-ls")

	local formatting = null_ls.builtins.formatting

	null_ls.setup({
		debug = true,
		sources = {
			formatting.stylua,
			formatting.prettier.with({
				extra_filetypes = { "typescriptreact", "javascriptreact", "md", "json", "yaml", "toml" },
				condition = function(utils)
					return utils.root_has_file(".prettierrc") or utils.root_has_file("prettier.config.js")
				end,
			}),
			null_ls.builtins.completion.spell,
		},
		on_attach = function(client, bufnr)
			if client.supports_method("textDocument/formatting") then
				-- format on save
				vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					group = group,
					callback = function()
						-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
						-- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
						vim.lsp.buf.format({
							bufnr = bufnr,
							async = async,
						})
					end,
					-- callback = function()
					--   vim.lsp.buf.format { bufnr = bufnr, async = async }
					-- end,
					desc = "[lsp] format on save",
				})
			end
		end,
	})
end

return M
