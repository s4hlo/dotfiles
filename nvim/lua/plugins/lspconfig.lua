local M = {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{
			"folke/lazydev.nvim",
			ft = "lua", -- only load on lua files
		},
	},
}

local N = {
	"antosha417/nvim-lsp-file-operations",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
}

function N.config() require("lsp-file-operations").setup() end

function M.common_capabilities()
	local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
	if status_ok then return cmp_nvim_lsp.default_capabilities() end

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities.textDocument.completion.completionItem.resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	}

	return capabilities
end

function M.config()
	local lspconfig = require("lspconfig")
	local icons = require("user.icons")

	local servers = {
		"jdtls",
		"cssls",
		"html",
		"ts_ls",
		"astro",
		"pyright",
		"jsonls",
		"bashls",
		"yamlls",
		"marksman",
		"tailwindcss",
		"lua_ls",
		"clangd",
		-- + add more servers here as needed
	}

	local default_diagnostic_config = {
		signs = {
			active = true,
			values = {
				{ name = "DiagnosticSignError", text = icons.diagnostics.Error },
				{ name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
				{ name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
				{ name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
			},
		},
		virtual_text = false,
		update_in_insert = false,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = require("user.config").border,
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(default_diagnostic_config)

	for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
	end

	vim.lsp.handlers["textDocument/hover"] =
		vim.lsp.with(vim.lsp.handlers.hover, { border = require("user.config").border })
	vim.lsp.handlers["textDocument/signatureHelp"] =
		vim.lsp.with(vim.lsp.handlers.signature_help, { border = require("user.config").border })
	require("lspconfig.ui.windows").default_options.border = require("user.config").border

	for _, server in pairs(servers) do
		local opts = {
			on_attach = M.on_attach,
			capabilities = M.common_capabilities(),
			init_options = {
				preferences = {
					importModuleSpecifierPreference = "relative",
					importModuleSpecifierEnding = "minimal",
				},
			},
		}

		local require_ok, settings = pcall(require, "user.lspsettings." .. server)
		if require_ok then opts = vim.tbl_deep_extend("force", settings, opts) end

		lspconfig[server].setup(opts)
	end

	require("lspconfig")["pyright"].setup({
		on_attach = M.on_attach,
		capabilities = M.common_capabilities(),
		settings = {
			python = {
				analysis = {
					diagnosticSeverityOverrides = {
						reportUnusedExpression = "none",
						reportAttributeAccessIssue = "none",
					},
				},
			},
		},
	})
end

return { M, N }
