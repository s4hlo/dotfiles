local M = {
	"rcarriga/nvim-notify",
	event = "VeryLazy",
}

function M.config()
	local colors = require("user.colors")
	require("notify").setup({
		background_colour = colors.pure_black,
	})
end

return M
