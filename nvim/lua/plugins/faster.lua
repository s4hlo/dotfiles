local N = {
	"LunarVim/bigfile.nvim",
	event = { "BufReadPre", "FileReadPre" },
}

function N.config()
	require("bigfile").setup({
		filesize = 2, -- size of the file in MiB, the plugin round file sizes to the closest MiB
		pattern = { "*" }, -- autocmd pattern or function see <### Overriding the detection of big files>
		features = { -- features to disable
			"indent_blankline",
			"illuminate",
			"lsp",
			"treesitter",
			"syntax",
			"matchparen",
			"vimopts",
			"filetype",
		},
	})
end

local J = {
	"karb94/neoscroll.nvim",
	opts = {},
	event = { "BufReadPost", "BufNewFile" },
}

return { N, J }
