local M = {
    "mistweaverco/kulala.nvim",
    keys = {
    },
    ft = { "http", "rest" },
    opts = {
      -- your configuration comes here
      global_keymaps = false,
      -- global_keymaps_prefix = "<leader>R",
      -- kulala_keymaps_prefix = "",
    },
}

function M.get_keys()
	return {
		{ "<leader>k", group = "Http" },
		{ "<leader>ks", "<cmd>lua require('kulala').run()<cr>", desc = "Send request", mode = { "n", "v" } },
		{ "<leader>ka", "<cmd>lua require('kulala').run_all()<cr>", desc = "Send all requests", mode = { "n", "v" } },
		{ "<leader>kr", "<cmd>lua require('kulala').replay()<cr>", desc = "Replay the last request" },
		{ "<leader>ke", "<cmd>lua require('kulala').set_selected_env()<cr>", desc = "Select enviroment" },
	}
end

return M
