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
	event = { "BufReadPre", "BufNewFile" },
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
	local icons = require("user.icons")

	local servers = {
		"cssls",
		"html",
		"ts_ls",
		"astro",
		"jsonls",
		"bashls",
		"yamlls",
		"marksman",
		"tailwindcss",
		"lua_ls",
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
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(default_diagnostic_config)

	for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
	end

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
	local ok, lspconfig_ui = pcall(require, "lspconfig.ui.windows")
	if ok then
		lspconfig_ui.default_options.border = "rounded"
	end

	for _, server in pairs(servers) do
		local opts = {
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

		vim.lsp.config(server, opts)
		vim.lsp.enable(server)
	end
end

function M.get_keys()
	return {
		{ "<leader>l", group = "LSP", mode = { "n", "v" } },
		{ "<leader>lw", "<cmd>%s/\r//g<cr>", desc = "Remove ^M characters", mode = "v" },
		{ "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action", mode = "n" },
		{ "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename", mode = "n" },
		{ "<leader>lh", "<cmd>lua vim.diagnostic.open_float()<CR>", desc = "Diagnostics (float)", mode = "n" },
		{ "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<cr>", desc = "Next Diagnostic", mode = "n" },
		{ "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", desc = "Prev Diagnostic", mode = "n" },
		{
			"<leader>lf",
			function()
				require("conform").format({
					async = false,
					lsp_fallback = true,
				})
			end,
			desc = "Format",
			mode = "n",
		},
	}
end

return { M, N }
