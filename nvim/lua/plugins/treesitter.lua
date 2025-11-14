local M = {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
			event = "VeryLazy",
		},
		{
			"JoosepAlviste/nvim-ts-context-commentstring",
			event = "VeryLazy",
		},
		{
			"windwp/nvim-ts-autotag",
			event = "VeryLazy",
		},
	},
}
function M.config()
	local required_parsers = {
		"lua",
		"typescript",
		"markdown",
		"markdown_inline",
		"bash",
		"python",
		"java",
	}

	-- Validate parsers are available before using
	local available_parsers = {}
	local success, parsers = pcall(require, "nvim-treesitter.parsers")
	if success and parsers then
		local parser_configs = parsers.get_parser_configs()
		for _, parser_name in ipairs(required_parsers) do
			if parser_configs[parser_name] ~= nil then
				table.insert(available_parsers, parser_name)
			end
		end
	else
		-- Fallback: use all required parsers if validation fails
		available_parsers = required_parsers
	end

	require("nvim-treesitter.configs").setup({
		ensure_installed = available_parsers,
		ignore_install = { "" },
		auto_install = true,
		sync_install = false, -- Changed to false for faster startup time

		highlight = {
			enable = true,
			-- disable = { "markdown" },
			additional_vim_regex_highlighting = false,
		},

		indent = { enable = true },

		matchup = {
			enable = { "astro" },
			disable = { "lua" },
		},

		autotag = { enable = true },

		autopairs = { enable = true },

		textobjects = {
			select = {
				enable = true,
				-- Automatically jump forward to textobj, similar to targets.vim
				lookahead = true,
				keymaps = {
					-- You can use the capture groups defined in textobjects.scm
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["at"] = "@class.outer",
					["it"] = "@class.inner",
					["ac"] = "@call.outer",
					["ic"] = "@call.inner",
					["aa"] = "@parameter.outer",
					["ia"] = "@parameter.inner",
					["al"] = "@loop.outer",
					["il"] = "@loop.inner",
					["ai"] = "@conditional.outer",
					["ii"] = "@conditional.inner",
					["a/"] = "@comment.outer",
					["i/"] = "@comment.inner",
					["ab"] = "@block.outer",
					["ib"] = "@block.inner",
					["as"] = "@statement.outer",
					["is"] = "@scopename.inner",
					["aA"] = "@attribute.outer",
					["iA"] = "@attribute.inner",
					["aF"] = "@frame.outer",
					["iF"] = "@frame.inner",
				},
			},
		},
	})
end

return M
