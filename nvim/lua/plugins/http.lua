local M = {
	"romek-codes/bruno.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        -- Pickers
        -- Choose one based on whichever picker you prefer.
        "nvim-telescope/telescope.nvim",
        -- Or
        -- "ibhagwan/fzf-lua",
        -- Or
        -- {
        --     "folke/snacks.nvim",
        --     opts = { picker = { enabled = true } },
        -- },
    },
	config = function()
		require("bruno").setup(
            {
                -- Paths to your bruno collections.
                collection_paths = {
                    { name = "Main", path = "~/dev/bruno-tarken" },
                }, 
                -- Which picker to use, "fzf-lua" or "snacks" are also allowed.
                picker = "telescope", 
                -- If output should be formatted by default.
                show_formatted_output = true, 
                -- If formatting fails for whatever reason, don't show error message (will always fallback to unformatted output).
                suppress_formatting_errors = false
            }
        )
	end
}

local N = {
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

function N.get_keys()
	return {
		{ "<leader>k", group = "Http" },
		{ "<leader>ks", "<cmd>lua require('kulala').run()<cr>", desc = "Send request", mode = { "n", "v" } },
		{ "<leader>ka", "<cmd>lua require('kulala').run_all()<cr>", desc = "Send all requests", mode = { "n", "v" } },
		{ "<leader>kr", "<cmd>lua require('kulala').replay()<cr>", desc = "Replay the last request" },
		{ "<leader>ke", "<cmd>lua require('kulala').set_selected_env()<cr>", desc = "Select enviroment" },
	}
end

return N
