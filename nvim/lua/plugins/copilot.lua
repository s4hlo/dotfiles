local M = {
	"zbirenbaum/copilot.lua",
}

function M.config()
	require("copilot").setup({
		suggestion = { enabled = true, auto_refresh = true },
		panel = { enabled = true },
	})
end

return M
