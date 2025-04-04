local M = {
	"folke/which-key.nvim",
	event = "VeryLazy",
	commit = "ce741eb559c924d72e3a67d2189ad3771a231414",
}

-- help function to deal with jupyter cells
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
	local mappings = {
		["e"] = { "<cmd>Neotree reveal toggle filesystem<CR>", "Explorer" },
		f = {
			name = "Find",
			b = { "<cmd>Telescope buffers previewer=false<cr>", "buffers" },
			c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
			f = { "<cmd>Telescope find_files hidden=true<cr>", "Find files" },
			t = { "<cmd>Telescope live_grep<cr>", "Find Text" },
			s = { "<cmd>Telescope grep_string<cr>", "Find String" },
			h = { "<cmd>Telescope help_tags<cr>", "Help" },
			H = { "<cmd>Telescope highlights<cr>", "Highlights" },
			l = { "<cmd>Telescope resume<cr>", "Last Search" },
			M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
			r = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
			R = { "<cmd>Telescope registers<cr>", "Registers" },
			k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
			C = { "<cmd>Telescope commands<cr>", "Commands" },
		},

		g = {
			name = "Git",
			j = { "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>", "Next Hunk" },
			k = { "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>", "Prev Hunk" },
			l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
			p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
			r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
			R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
			s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
			u = {
				"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
				"Undo Stage Hunk",
			},
			c = {
				name = "Conflict",
				o = { "<cmd>GitConflictChooseOurs<cr>", "Choose Ours" },
				t = { "<cmd>GitConflictChooseTheirs<cr>", "Choose Theirs" },
				b = { "<cmd>GitConflictChooseBoth<cr>", "Choose Both" },
				N = { "<cmd>GitConflictChooseNone<cr>", "Choose None" },
				n = { "<cmd>GitConflictNextConflict<cr>", "Next Conflict" },
				p = { "<cmd>GitConflictPrevConflict<cr>", "Prev Conflict" },
			},
			o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
			b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
			C = {
				"<cmd>Telescope git_bcommits<cr>",
				"Checkout commit(for current file)",
			},
			d = { "<cmd>DiffviewOpen<cr>", "Open Diffview" },
		},

		l = {
			name = "LSP",
			I = { "<cmd>Glance implementations()<CR>", "Implementations" },
			D = { "<cmd>Glance definitions()<CR>", "Definitions" },
			T = { "<cmd>Glance type_definitions()<CR>", "Type Definitions" },
			i = { "<cmd>LspInfo<cr>", "Info" },
			-- f = { "<cmd>lua vim.lsp.buf.format({timeout_ms = 1000000})<cr>", "Format" },
			f = {
				function()
					vim.lsp.buf.format({
						filter = function(cliente)
							return cliente.name == "null-ls" --this ensures null_ls client is called to format, not normal LspFormatting
						end,
						async = false,
					})
				end,
				"Format",
			},
			a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
			r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
			l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
			h = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Diagnostics" },
			j = {
				"<cmd>lua vim.diagnostic.goto_next()<cr>",
				"Next Diagnostic",
			},
			k = {
				"<cmd>lua vim.diagnostic.goto_prev()<cr>",
				"Prev Diagnostic",
			},
			q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
			d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
			w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
			s = { "<cmd>Neotree float toggle document_symbols<CR>", "Document Symbols" },
			-- s = {
			-- 	"<cmd>lua require('telescope.builtin').lsp_document_symbols({ symbols = { 'Class', 'Method', 'Constructor' } })<CR>",
			-- 	"Class Methods & Constructors",
			-- },
			S = {
				"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
				"Workspace Symbols",
			},
			e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
		},

		m = {
			name = "Molten",
			s = { "<cmd>:lua SelectNextPythonCodeBlock()<CR>", "Select cell" },
			j = { "<cmd>MoltenNext<CR>", "Next Cell" },
			k = { "<cmd>MoltenPrev<CR>", "Prev Cell" },
			o = { "<cmd>MoltenEvaluateOperator<CR>", "Evaluate Operator" },
			x = { "<cmd>noautocmd MoltenEnterOutput<CR>", "Open Output" },
			e = { "<cmd>MoltenReevaluateCell<CR>", "Re-eval Cell" },
			h = { "<cmd>MoltenHideOutput<CR>", "Close Output" },
			d = { "<cmd>MoltenDelete<CR>", "Delete Cell" },
			i = { "<cmd>MoltenInit<CR>", "Init" },
		},

		d = {
			name = "Debug",
			t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
			b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
			c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
			C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
			d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
			g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
			S = {
				function()
					require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
				end,
				"Conditional Breakpoint",
			},
			i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
			o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
			u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
			p = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
			r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
			s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
			q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
			U = { "<cmd>lua require'dapui'.toggle({reset = true})<cr>", "Toggle UI" },
		},
	}

	local opts = {
		mode = "n", -- NORMAL mode
		prefix = "<leader>",
		buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
		silent = true, -- use `silent` when creating keymaps
		noremap = true, -- use `noremap` when creating keymaps
		nowait = true, -- use `nowait` when creating keymaps
	}

	-- NOTE: Prefer using : over <cmd> as the latter avoids going back in normal-mode.
	-- see https://neovim.io/doc/user/map.html#:map-cmd
	local vmappings = {
		["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment toggle linewise (visual)" },
		l = {
			name = "LSP",
			a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
		},
		m = {
			name = "Molten",
			e = { ":<C-u>MoltenEvaluateVisual<CR>", "Evaluate Visual" },
		},
	}

	local vopts = {
		mode = "v", -- VISUAL mode
		prefix = "<leader>",
		buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
		silent = true, -- use `silent` when creating keymaps
		noremap = true, -- use `noremap` when creating keymaps
		nowait = true, -- use `nowait` when creating keymaps
	}

	local which_key = require("which-key")

	which_key.setup({
		plugins = {
			marks = false, -- shows a list of your marks on ' and `
			registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
			spelling = {
				enabled = true,
				suggestions = 20,
			}, -- use which-key for spelling hints
			-- the presets plugin, adds help for a bunch of default keybindings in Neovim
			-- No actual key bindings are created
			presets = {
				operators = true, -- adds help for operators like d, y, ...
				motions = false, -- adds help for motions
				text_objects = false, -- help for text objects triggered after entering an operator
				windows = true, -- default bindings on <c-w>
				nav = true, -- misc bindings to work with windows
				z = true, -- bindings for folds, spelling and others prefixed with z
				g = true, -- bindings for prefixed with g
			},
		},
		popup_mappings = {
			scroll_down = "<c-d>", -- binding to scroll down inside the popup
			scroll_up = "<c-u>", -- binding to scroll up inside the popup
		},
		window = {
			border = "rounded", -- none, single, double, shadow
			position = "bottom", -- bottom, top
			margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
			padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
			winblend = 0,
		},
		layout = {
			height = { min = 4, max = 25 }, -- min and max height of the columns
			width = { min = 20, max = 50 }, -- min and max width of the columns
			spacing = 3, -- spacing between columns
			align = "left", -- align columns left, center or right
		},
		ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
		hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
		show_help = true, -- show help message on the command line when the popup is visible
		show_keys = true, -- show the currently pressed key and its label as a message in the command line
		triggers = "auto", -- automatically setup triggers
		-- triggers = {"<leader>"} -- or specify a list manually
		triggers_blacklist = {
			-- list of mode / prefixes that should never be hooked by WhichKey
			-- this is mostly relevant for key maps that start with a native binding
			-- most people should not need to change this
			i = { "j", "k" },
			v = { "j", "k" },
		},
		-- disable the WhichKey popup for certain buf types and file types.
		-- Disabled by default for Telescope
		disable = {
			buftypes = {},
			filetypes = { "TelescopePrompt" },
		},
	})

	which_key.register(mappings, opts)
	which_key.register(vmappings, vopts)
end

return M
