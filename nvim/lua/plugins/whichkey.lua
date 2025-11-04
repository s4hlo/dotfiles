local neotree_key = require("user.config").clean
		and {
			{
				"<A-e>",
				function()
					if vim.bo.filetype == "neo-tree" then
						vim.cmd("wincmd p")
					else
						-- run twice to when symbols is not the current tab
						vim.cmd("Neotree")
						vim.cmd("Neotree")
					end
				end,
				desc = "Explorer (clean)",
				mode = "n",
			},
			{ "<C-p>", "<cmd>Telescope find_files hidden=true<cr>", desc = "Find File", mode = "n" },
			{ "<A-f>", "<cmd>Telescope live_grep<cr>", desc = "Find Text", mode = "n" },
			{
				-- TODO (s4hlo) make it better
				"<A-s>",
				function()
					if vim.bo.filetype == "neo-tree" then
						vim.cmd("wincmd p")
					else
						vim.cmd("Neotree document_symbols")
					end
				end,
				desc = "Document Symbols (clean)",
				mode = "n",
			},
		}
	or {
		{ "<C-p>", "<cmd>Telescope find_files hidden=true<cr>", desc = "Find File", mode = "n" },
		{ "<A-f>", "<cmd>Telescope live_grep<cr>", desc = "Find Text", mode = "n" },
		{ "<A-e>", "<cmd>Neotree reveal toggle filesystem<CR>", desc = "Explorer", mode = "n" },
		{ "<A-g>", "<cmd>Telescope git_status<cr>", desc = "Open Changed File", mode = "n" },
		{ "<A-s>", "<cmd>Neotree float toggle document_symbols<CR>", desc = "Document Symbols", mode = "n" },
	}

local M = {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
	keys = neotree_key,
}

-- molten
SelectNextPythonCodeBlock2 = function()
	local save_cursor = vim.api.nvim_win_get_cursor(0)
	local current_line = save_cursor[1]

	vim.api.nvim_win_set_cursor(0, { current_line, 0 })
	local start_line = vim.fn.search("```{python}", "bnW")

	vim.api.nvim_win_set_cursor(0, { current_line, 0 })
	local end_line = vim.fn.search("```", "nW")

	if start_line ~= 0 and end_line ~= 0 then
		vim.api.nvim_win_set_cursor(0, { start_line + 1, 0 })
		vim.cmd("normal! V")
		vim.api.nvim_win_set_cursor(0, { end_line - 1, 0 })
	else
		vim.api.nvim_win_set_cursor(0, save_cursor)
	end
end

SelectNextPythonCodeBlock = function()
	local save_cursor = vim.api.nvim_win_get_cursor(0)
	local current_line = save_cursor[1]
	local last_line = vim.api.nvim_buf_line_count(0)

	-- Procura a célula atual ou a próxima
	local start_line = vim.fn.search("^# %%%%", "nW", current_line)
	if start_line == 0 then
		-- Se não achar nenhuma célula à frente, mantém a posição
		vim.api.nvim_win_set_cursor(0, save_cursor)
		return
	end

	-- Procura a próxima célula para determinar o fim
	local end_line = vim.fn.search("^# %%%%", "nW", start_line + 1)
	if end_line == 0 then
		end_line = last_line + 1 -- seleciona até o final do arquivo
	end

	-- Seleciona a célula
	vim.api.nvim_win_set_cursor(0, { start_line + 1, 0 })
	vim.cmd("normal! V")
	vim.api.nvim_win_set_cursor(0, { end_line - 1, 0 })
end

function M.config()
	local which_key = require("which-key")

	which_key.setup({
		triggers = {
			{ "<leader>", mode = { "n", "v" } },
			{ "z", mode = { "n", "v" } },
		},
		win = {
			border = require("user.config").border,
		},
		disable = {
			buftypes = {},
			filetypes = { "TelescopePrompt" },
		},
	})
	local ufo = require("ufo")
	which_key.add({
		{ "ZR", ufo.openAllFolds, desc = "Open all folds", mode = "n" },
		{ "ZM", ufo.closeAllFolds, desc = "Close all folds", mode = "n" },
	})

	local ai_keys = {
		{ "<leader>a", group = "AI", mode = { "n", "v" } },
	}

	local find_keys = {
		{ "<leader>f", group = "Find" },
		-- { "<leader>ff", "<cmd>Telescope find_files hidden=true<cr>", desc = "Find File", mode = "n" },
		{ "<leader>fb", "<cmd>Telescope buffers previewer=false<cr>", desc = "Buffers", mode = "n" },
		-- { "<leader>ft", "<cmd>Telescope live_grep<cr>", desc = "Find Text", mode = "n" },
		{ "<leader>fs", "<cmd>Telescope grep_string<cr>", desc = "Find String", mode = "n" },
		{ "<leader>fl", "<cmd>Telescope resume<cr>", desc = "Last Search", mode = "n" },
		{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent File", mode = "n" },
		{ "<leader>fR", "<cmd>Telescope registers<cr>", desc = "Recents", mode = "n" },
	}

	local lps_keys = {
		{ "<leader>l", group = "LSP", mode = { "n", "v" } },
		{ "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action", mode = "v" },
		{ "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action", mode = "n" },
		{ "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename", mode = "n" },
		{ "<leader>lh", "<cmd>lua vim.diagnostic.open_float()<CR>", desc = "Diagnostics", mode = "n" },
		{ "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<cr>", desc = "Next Diagnostic", mode = "n" },
		{ "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", desc = "Prev Diagnostic", mode = "n" },
		{ "<leader>ld", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics", mode = "n" },
		{
			"<leader>lf",
			function()
				vim.lsp.buf.format({
					filter = function(cliente)
						return cliente.name == "null-ls" --this ensures null_ls client is called to format, not normal LspFormatting
					end,
					async = false,
				})
			end,
			desc = "Format (null-ls only)",
			mode = "n",
		},
	}

	local git_keys = {
		{ "<leader>g", group = "Git" },
		{ "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>", desc = "Next Hunk", mode = "n" },
		{ "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>", desc = "Prev Hunk", mode = "n" },
		{ "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>", desc = "Blame", mode = "n" },
		{ "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", desc = "Preview Hunk", mode = "n" },
		{ "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", desc = "Reset Hunk", mode = "n" },
		{ "<leader>gS", "<cmd>lua require 'gitsigns'.stage_buffer()<cr>", desc = "stage_buffer", mode = "n" },
		{ "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", desc = "Reset Buffer", mode = "n" },
		{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview", mode = "n" },

		{ "<leader>gc", group = "Conflict" },
		{ "<leader>gco", "<cmd>GitConflictChooseOurs<cr>", desc = "Choose Ours", mode = "n" },
		{ "<leader>gct", "<cmd>GitConflictChooseTheirs<cr>", desc = "Choose Theirs", mode = "n" },
		{ "<leader>gcb", "<cmd>GitConflictChooseBoth<cr>", desc = "Choose Both", mode = "n" },
		{ "<leader>gcN", "<cmd>GitConflictChooseNone<cr>", desc = "Choose None", mode = "n" },
		{ "<leader>gcn", "<cmd>GitConflictNextConflict<cr>", desc = "Next Conflict", mode = "n" },
		{ "<leader>gcp", "<cmd>GitConflictPrevConflict<cr>", desc = "Prev Conflict", mode = "n" },
	}

	local debug_keys = {
		{ "<leader>d", group = "Debug" },
		{ "<leader>dt", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", desc = "Toggle Breakpoint", mode = "n" },
		{ "<leader>db", "<cmd>lua require'dap'.step_back()<cr>", desc = "Step Back", mode = "n" },
		{ "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", desc = "Continue", mode = "n" },
		{ "<leader>dC", "<cmd>lua require'dap'.run_to_cursor()<cr>", desc = "Run To Cursor", mode = "n" },
		{ "<leader>dd", "<cmd>lua require'dap'.disconnect()<cr>", desc = "Disconnect", mode = "n" },
		{ "<leader>dg", "<cmd>lua require'dap'.session()<cr>", desc = "Get Session", mode = "n" },
		{ "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", desc = "Step Into", mode = "n" },
		{ "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", desc = "Step Over", mode = "n" },
		{ "<leader>du", "<cmd>lua require'dap'.step_out()<cr>", desc = "Step Out", mode = "n" },
		{ "<leader>dp", "<cmd>lua require'dap'.pause()<cr>", desc = "Pause", mode = "n" },
		{ "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", desc = "Toggle Repl", mode = "n" },
		{ "<leader>ds", "<cmd>lua require'dap'.continue()<cr>", desc = "Start", mode = "n" },
		{ "<leader>dq", "<cmd>lua require'dap'.close()<cr>", desc = "Quit", mode = "n" },
		{ "<leader>dU", "<cmd>lua require'dapui'.toggle({reset = true})<cr>", desc = "Toggle UI", mode = "n" },
		{
			"<leader>dS",
			function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
			desc = "Conditional Breakpoint",
			mode = "n",
		},
	}

	local molten_keys = {
		{ "<leader>m", group = "Molten" },
		{ "<leader>ms", "<cmd>lua SelectNextPythonCodeBlock()<CR>", desc = "Select cell", mode = "n" },
		{ "<leader>mj", "<cmd>MoltenNext<CR>", desc = "Next Cell", mode = "n" },
		{ "<leader>mk", "<cmd>MoltenPrev<CR>", desc = "Prev Cell", mode = "n" },
		{ "<leader>mo", "<cmd>MoltenEvaluateOperator<CR>", desc = "Evaluate Operator", mode = "n" },
		{ "<leader>mx", "<cmd>noautocmd MoltenEnterOutput<CR>", desc = "Open Output", mode = "n" },
		{ "<leader>me", "<cmd>MoltenReevaluateCell<CR>", desc = "Re-eval Cell", mode = "n" },
		{ "<leader>mh", "<cmd>MoltenHideOutput<CR>", desc = "Close Output", mode = "n" },
		{ "<leader>md", "<cmd>MoltenDelete<CR>", desc = "Delete Cell", mode = "n" },
		{ "<leader>mi", "<cmd>MoltenInit<CR>", desc = "Init", mode = "n" },
	}

	which_key.add(ai_keys)
	which_key.add(molten_keys)
	which_key.add(debug_keys)

	which_key.add(find_keys)
	which_key.add(lps_keys)
	which_key.add(git_keys)
end

return M
