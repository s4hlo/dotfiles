local M = {
	"mfussenegger/nvim-lint",
	opts = {},
}

function M.config() require("conform").setup({}) end

return M
