local M = {
	"rcarriga/nvim-notify",
}

function M.config()
	local colors = require("user.colors")
	require("notify").setup({
		-- background_colour = colors.pure_white,
	})
end

return M
