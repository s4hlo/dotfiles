local M = {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
	keys = {
		{ "<leader>e", "<cmd>Neotree reveal toggle filesystem<CR>", desc = "Explorer", mode = "n" },
	},
}

-- molten
SelectNextPythonCodeBlock = function()
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

function M.config()
	local which_key = require("which-key")

	which_key.setup({
		triggers = {
			{ "<leader>", mode = { "n", "v" } },
			{ "z", mode = { "n", "v" } },
		},
		win = {
			no_overlap = true,
			border = "rounded",
			padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
			title = true,
			title_pos = "center",
			zindex = 1000,
			bo = {},
			wo = {
				-- winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
			},
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
		{
			"ZK",
			function()
				local winid = ufo.peekFoldedLinesUnderCursor()
				if not winid then vim.lsp.buf.hover() end
			end,
			desc = "Peek Fold",
			mode = "n",
		},
	})

	which_key.add({
		{ "<leader>e", "<cmd>Neotree reveal toggle filesystem<CR>", desc = "Explorer", mode = "n" },
	})
	which_key.add({
		{ "<leader>a", group = "AI", mode = { "n", "v" } },
	})

	which_key.add({
		{ "<leader>f", group = "Find" },
		{
			"<leader>ff",
			"<cmd>Telescope find_files hidden=true<cr>",
			desc = "Find File",
			mode = "n",
		},
		{
			"<leader>fb",
			"<cmd>Telescope buffers previewer=false<cr>",
			desc = "Buffers",
			mode = "n",
		},
		{ "<leader>fc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme", mode = "n" },
		{ "<leader>ft", "<cmd>Telescope live_grep<cr>", desc = "Find Text", mode = "n" },
		{ "<leader>fs", "<cmd>Telescope grep_string<cr>", desc = "Find String", mode = "n" },
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help", mode = "n" },
		{ "<leader>fH", "<cmd>Telescope highlights<cr>", desc = "Highlights", mode = "n" },
		{ "<leader>fl", "<cmd>Telescope resume<cr>", desc = "Last Search", mode = "n" },
		{ "<leader>fM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages", mode = "n" },
		{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent File", mode = "n" },
		{ "<leader>fR", "<cmd>Telescope registers<cr>", desc = "Recents", mode = "n" },
		{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps", mode = "n" },
		{ "<leader>fC", "<cmd>Telescope commands<cr>", desc = "Commands", mode = "n" },
	})

	which_key.add({
		{ "<leader>l", group = "LSP", mode = { "n", "v" } },
		{
			"<leader>la",
			"<cmd>lua vim.lsp.buf.code_action()<cr>",
			desc = "Code Action",
			mode = "v",
		},
		{
			"<leader>lF",
			"<cmd>lua vim.lsp.buf.format({timeout_ms = 1000000})<cr>",
			desc = "Format",
			mode = "n",
		},
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
		{
			"<leader>lI",
			"<cmd>Glance implementations()<CR>",
			desc = "Implementations",
			mode = "n",
		},
		{
			"<leader>lD",
			"<cmd>Glance definitions()<CR>",
			desc = "Definitions",
			mode = "n",
		},
		{
			"<leader>lT",
			"<cmd>Glance type_definitions()<CR>",
			desc = "Type Definitions",
			mode = "n",
		},
		{
			"<leader>li",
			"<cmd>LspInfo<cr>",
			desc = "Info",
			mode = "n",
		},
		{
			"<leader>la",
			"<cmd>lua vim.lsp.buf.code_action()<cr>",
			desc = "Code Action",
			mode = "n",
		},
		{
			"<leader>lr",
			"<cmd>lua vim.lsp.buf.rename()<cr>",
			desc = "Rename",
			mode = "n",
		},
		{
			"<leader>ll",
			"<cmd>lua vim.lsp.codelens.run()<cr>",
			desc = "CodeLens Action",
			mode = "n",
		},
		{
			"<leader>lh",
			"<cmd>lua vim.diagnostic.open_float()<CR>",
			desc = "Diagnostics",
			mode = "n",
		},
		{
			"<leader>lj",
			"<cmd>lua vim.diagnostic.goto_next()<cr>",
			desc = "Next Diagnostic",
			mode = "n",
		},
		{
			"<leader>lk",
			"<cmd>lua vim.diagnostic.goto_prev()<cr>",
			desc = "Prev Diagnostic",
			mode = "n",
		},
		{
			"<leader>lq",
			"<cmd>lua vim.diagnostic.setloclist()<cr>",
			desc = "Quickfix",
			mode = "n",
		},
		{
			"<leader>ld",
			"<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>",
			desc = "Buffer Diagnostics",
			mode = "n",
		},
		{ "<leader>lw", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics", mode = "n" },
		{
			"<leader>ls",
			"<cmd>Neotree float toggle document_symbols<CR>",
			desc = "Document Symbols",
			mode = "n",
		},
		-- { "<leader>ls", "<cmd>lua require('telescope.builtin').lsp_document_symbols({ symbols = { 'Class', 'Method', 'Constructor' } })<CR>", desc = "Class Methods & Constructors", mode = "n" },
		{
			"<leader>lS",
			"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
			desc = "Workspace Symbols",
			mode = "n",
		},
		{ "<leader>le", "<cmd>Telescope quickfix<cr>", desc = "Telescope Quickfix", mode = "n" },
	})

	which_key.add({
		{ "<leader>g", group = "Git" },
		{
			"<leader>gj",
			"<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>",
			desc = "Next Hunk",
			mode = "n",
		},
		{
			"<leader>gk",
			"<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>",
			desc = "Prev Hunk",
			mode = "n",
		},
		{
			"<leader>gl",
			"<cmd>lua require 'gitsigns'.blame_line()<cr>",
			desc = "Blame",
			mode = "n",
		},
		{
			"<leader>gp",
			"<cmd>lua require 'gitsigns'.preview_hunk()<cr>",
			desc = "Preview Hunk",
			mode = "n",
		},
		{
			"<leader>gr",
			"<cmd>lua require 'gitsigns'.reset_hunk()<cr>",
			desc = "Reset Hunk",
			mode = "n",
		},
		{
			"<leader>gR",
			"<cmd>lua require 'gitsigns'.reset_buffer()<cr>",
			desc = "Reset Buffer",
			mode = "n",
		},
		{
			"<leader>gs",
			"<cmd>lua require 'gitsigns'.stage_hunk()<cr>",
			desc = "Stage Hunk",
			mode = "n",
		},
		{
			"<leader>gu",
			"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
			desc = "Undo Stage Hunk",
			mode = "n",
		},
		{
			"<leader>go",
			"<cmd>Telescope git_status<cr>",
			desc = "Open Changed File",
			mode = "n",
		},
		{
			"<leader>gb",
			"<cmd>Telescope git_branches<cr>",
			desc = "Checkout Branch",
			mode = "n",
		},
		{
			"<leader>gC",
			"<cmd>Telescope git_bcommits<cr>",
			desc = "Checkout Commit (Current File)",
			mode = "n",
		},
		{
			"<leader>gd",
			"<cmd>DiffviewOpen<cr>",
			desc = "Open Diffview",
			mode = "n",
		},

		{ "<leader>gc", group = "Conflict" },
		{
			"<leader>gco",
			"<cmd>GitConflictChooseOurs<cr>",
			desc = "Choose Ours",
			mode = "n",
		},
		{
			"<leader>gct",
			"<cmd>GitConflictChooseTheirs<cr>",
			desc = "Choose Theirs",
			mode = "n",
		},
		{
			"<leader>gcb",
			"<cmd>GitConflictChooseBoth<cr>",
			desc = "Choose Both",
			mode = "n",
		},
		{
			"<leader>gcN",
			"<cmd>GitConflictChooseNone<cr>",
			desc = "Choose None",
			mode = "n",
		},
		{
			"<leader>gcn",
			"<cmd>GitConflictNextConflict<cr>",
			desc = "Next Conflict",
			mode = "n",
		},
		{
			"<leader>gcp",
			"<cmd>GitConflictPrevConflict<cr>",
			desc = "Prev Conflict",
			mode = "n",
		},
	})

	which_key.add({
		{ "<leader>d", group = "Debug" },

		{
			"<leader>dt",
			"<cmd>lua require'dap'.toggle_breakpoint()<cr>",
			desc = "Toggle Breakpoint",
			mode = "n",
		},
		{ "<leader>db", "<cmd>lua require'dap'.step_back()<cr>", desc = "Step Back", mode = "n" },
		{ "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", desc = "Continue", mode = "n" },
		{
			"<leader>dC",
			"<cmd>lua require'dap'.run_to_cursor()<cr>",
			desc = "Run To Cursor",
			mode = "n",
		},
		{ "<leader>dd", "<cmd>lua require'dap'.disconnect()<cr>", desc = "Disconnect", mode = "n" },
		{ "<leader>dg", "<cmd>lua require'dap'.session()<cr>", desc = "Get Session", mode = "n" },

		{
			"<leader>dS",
			function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
			desc = "Conditional Breakpoint",
			mode = "n",
		},

		{ "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", desc = "Step Into", mode = "n" },
		{ "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", desc = "Step Over", mode = "n" },
		{ "<leader>du", "<cmd>lua require'dap'.step_out()<cr>", desc = "Step Out", mode = "n" },
		{ "<leader>dp", "<cmd>lua require'dap'.pause()<cr>", desc = "Pause", mode = "n" },
		{
			"<leader>dr",
			"<cmd>lua require'dap'.repl.toggle()<cr>",
			desc = "Toggle Repl",
			mode = "n",
		},
		{ "<leader>ds", "<cmd>lua require'dap'.continue()<cr>", desc = "Start", mode = "n" },
		{ "<leader>dq", "<cmd>lua require'dap'.close()<cr>", desc = "Quit", mode = "n" },
		{
			"<leader>dU",
			"<cmd>lua require'dapui'.toggle({reset = true})<cr>",
			desc = "Toggle UI",
			mode = "n",
		},
	})

	-- molten
	which_key.add({
		{ "<leader>m", group = "Molten" },

		{
			"<leader>ms",
			"<cmd>lua SelectNextPythonCodeBlock()<CR>",
			desc = "Select cell",
			mode = "n",
		},
		{ "<leader>mj", "<cmd>MoltenNext<CR>", desc = "Next Cell", mode = "n" },
		{ "<leader>mk", "<cmd>MoltenPrev<CR>", desc = "Prev Cell", mode = "n" },
		{ "<leader>mo", "<cmd>MoltenEvaluateOperator<CR>", desc = "Evaluate Operator", mode = "n" },
		{ "<leader>mx", "<cmd>noautocmd MoltenEnterOutput<CR>", desc = "Open Output", mode = "n" },
		{ "<leader>me", "<cmd>MoltenReevaluateCell<CR>", desc = "Re-eval Cell", mode = "n" },
		{ "<leader>mh", "<cmd>MoltenHideOutput<CR>", desc = "Close Output", mode = "n" },
		{ "<leader>md", "<cmd>MoltenDelete<CR>", desc = "Delete Cell", mode = "n" },
		{ "<leader>mi", "<cmd>MoltenInit<CR>", desc = "Init", mode = "n" },
	})
end

return M
