local M = {
	"mfussenegger/nvim-lint",
	event = { "BufReadPost", "BufNewFile", "BufWritePost" },
}

function M.config()
	local lint = require("lint")

	lint.linters_by_ft = {
		-- add linters here, e.g. python = { "ruff" },
	}

	vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
		group = vim.api.nvim_create_augroup("Lint", { clear = true }),
		callback = function() lint.try_lint() end,
	})
end

return M
