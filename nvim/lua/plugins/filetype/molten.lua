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
		depends = { "3rd/image.nvim" },
		build = ":UpdateRemotePlugins",
		init = function()
			vim.g.molten_image_provider = "image.nvim"
			vim.g.molten_output_win_max_height = 40
			vim.g.molten_auto_open_output = false

			-- optional, I like wrapping. works for virt text and the output window
			vim.g.molten_wrap_output = true

			-- Output as virtual text. Allows outputs to always be shown, works with images, but can
			-- be buggy with longer images
			-- this make the image larger
			-- vim.g.molten_virt_text_output = true

			vim.g.molten_output_show_more = true

			-- vim.g.molten_output_win_border= true
			-- vim.g.molten_output_win_style= "minimal"

			-- this will make it so the output shows up below the \`\`\` cell delimiter
			vim.g.molten_virt_lines_off_by_1 = true
		end,
	},
}
