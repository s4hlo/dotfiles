return {
	{ -- requires plugins in lua/plugins/treesitter.lua and lua/plugins/lsp.lua
		-- for complete functionality (language features)
		"quarto-dev/quarto-nvim",
		ft = { "quarto", "markdown" },
		dev = false,
		opts = {},
		dependencies = {
			-- for language features in code cells
			-- configured in lua/plugins/lsp.lua and
			-- added as a nvim-cmp source in lua/plugins/completion.lua
			--
			{

				-- for lsp features in code cells / embedded code
				"jmbuhr/otter.nvim",
				dev = false,
				dependencies = {
					{
						"neovim/nvim-lspconfig",
						"nvim-treesitter/nvim-treesitter",
					},
				},
				opts = {},
			},
		},
		config = function()
			require("quarto").setup({
				lspFeatures = {
					-- NOTE: put whatever languages you want here:
					languages = { "r", "python", "rust" },
					chunks = "all",
					diagnostics = {
						enabled = true,
						triggers = { "BufWritePost" },
					},
					completion = {
						enabled = true,
					},
				},
				codeRunner = {
					enabled = true,
					default_method = "molten",
				},
			})
		end,
	},
	{
		"GCBallesteros/jupytext.nvim",
		config = function()
			require("jupytext").setup({
				style = "quarto",
				output_extension = "qmd",
				force_ft = "quarto",
			})
		end,
	},
	{
		"benlubas/molten-nvim",
		version = "^1.0.0",
		depends = {},
		build = ":UpdateRemotePlugins",
		init = function()
			-- Disable image support - text output only
			vim.g.molten_image_provider = "none"
			vim.g.molten_auto_image_popup = false

			-- Output window configuration
			vim.g.molten_auto_open_output = true -- Show output window automatically
			vim.g.molten_output_win_max_height = 40
			vim.g.molten_output_win_max_width = 999999
			vim.g.molten_output_show_more = true
			vim.g.molten_output_show_exec_time = true

			-- Virtual text output - shows output below code even when window is closed
			vim.g.molten_virt_text_output = true
			vim.g.molten_virt_text_max_lines = 12

			-- Text wrapping for better readability
			vim.g.molten_wrap_output = true

			-- Output window styling
			vim.g.molten_output_win_cover_gutter = true
			vim.g.molten_output_win_hide_on_leave = true
			vim.g.molten_output_crop_border = true

			-- Python host program (if using virtualenv)
			vim.g.python3_host_prog = "/home/sleig/.cache/pypoetry/virtualenvs/notebooks-WtJaZIpw-py3.12/bin/python"

			-- Better positioning for output below code cells
			vim.g.molten_virt_lines_off_by_1 = true
			vim.g.molten_cover_empty_lines = true

			-- Performance
			vim.g.molten_tick_rate = 500 -- Update rate in ms
			vim.g.molten_limit_output_chars = 1000000
		end,
		config = function()
			-- Setup keybindings for common operations
			local keymap = vim.keymap.set
			local opts = { noremap = true, silent = true }

			-- Initialize kernel
			keymap("n", "<localleader>mi", "<cmd>MoltenInit<CR>", vim.tbl_extend("force", opts, { desc = "Molten: Initialize kernel" }))

			-- Evaluate code
			keymap("n", "<localleader>rl", "<cmd>MoltenEvaluateLine<CR>", vim.tbl_extend("force", opts, { desc = "Molten: Evaluate line" }))
			keymap("v", "<localleader>r", ":<C-u>MoltenEvaluateVisual<CR>gv", vim.tbl_extend("force", opts, { desc = "Molten: Evaluate visual selection" }))
			keymap("n", "<localleader>e", "<cmd>MoltenEvaluateOperator<CR>", vim.tbl_extend("force", opts, { desc = "Molten: Evaluate operator" }))

			-- Cell management
			keymap("n", "<localleader>rr", "<cmd>MoltenReevaluateCell<CR>", vim.tbl_extend("force", opts, { desc = "Molten: Re-evaluate cell" }))
			keymap("n", "<localleader>rd", "<cmd>MoltenDelete<CR>", vim.tbl_extend("force", opts, { desc = "Molten: Delete cell" }))

			-- Output window
			keymap("n", "<localleader>ro", "<cmd>MoltenShowOutput<CR>", vim.tbl_extend("force", opts, { desc = "Molten: Show output" }))
			keymap("n", "<localleader>rh", "<cmd>MoltenHideOutput<CR>", vim.tbl_extend("force", opts, { desc = "Molten: Hide output" }))
			keymap("n", "<localleader>rx", "<cmd>noautocmd MoltenEnterOutput<CR>", vim.tbl_extend("force", opts, { desc = "Molten: Enter output" }))

			-- Interrupt execution
			keymap("n", "<localleader>ri", "<cmd>MoltenInterrupt<CR>", vim.tbl_extend("force", opts, { desc = "Molten: Interrupt" }))
		end,
	},
}
