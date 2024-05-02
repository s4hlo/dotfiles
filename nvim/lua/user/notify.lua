local M = {
	"rcarriga/nvim-notify",
}

function M.config()
	require("notify").setup({
		background_colour = "#ffffff",
	})
end

return M
