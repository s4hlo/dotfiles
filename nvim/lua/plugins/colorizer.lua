local M = {
	"norcalli/nvim-colorizer.lua",
	event = { "BufReadPost", "BufNewFile" },
}

M.config = function() require("colorizer").setup() end

return M
