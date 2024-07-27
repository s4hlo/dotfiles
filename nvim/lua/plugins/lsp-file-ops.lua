local M = {
	"antosha417/nvim-lsp-file-operations",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
}

function M.config()
	require("lsp-file-operations").setup()
end

return M
