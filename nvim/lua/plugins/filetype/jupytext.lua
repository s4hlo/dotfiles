local M = {
	"GCBallesteros/jupytext.nvim",
	-- config = true,
	-- Depending on your nvim distro or config you may need to make the loading not lazy
	-- lazy=false,
}

function M.config()
	require("jupytext").setup({
		style = "markdown",
		output_extension = "md",
		force_ft = "markdown",
		custom_language_formatting = {
			python = {
				extension = "qmd",
				style = "quarto",
				force_ft = "quarto", -- you can set whatever filetype you want here
			},
		},
	})
end
-- custom_language_formatting = {
--   python = {
--     extension = "qmd",
--     style = "quarto",
--     force_ft = "quarto", -- you can set whatever filetype you want here
--   },
-- }
-- {
--   style = "hydrogen",
--   output_extension = "auto",  -- Default extension. Don't change unless you know what you are doing
--   force_ft = nil,  -- Default filetype. Don't change unless you know what you are doing
--   custom_language_formatting = {},
-- }

return M
