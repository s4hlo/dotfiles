local M = {
	"catgoose/nvim-colorizer.lua", -- maintained fork; norcalli's calls deprecated vim.tbl_flatten
	event = { "BufReadPost", "BufNewFile" },
}

M.config = function() require("colorizer").setup() end

return M
