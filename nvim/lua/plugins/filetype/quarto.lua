local M = {
  "quarto-dev/quarto-nvim",
  ft = { "quarto", "markdown" },
  dependencies = {
    "jmbuhr/otter.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
}

function M.config()
  require("otter").setup {
    handle_leading_whitespace = true,
    lsp = {
      hover = { border = "none" },
    },
  }

  require("quarto").setup {
    lspFeatures = {
      languages = { "python", "rust", "lua", "markdown" },
      chunks = "all", -- 'curly' or 'all'
      diagnostics = {
        enabled = true,
        triggers = { "BufWritePost" },
      },
      completion = {
        enabled = true,
      },
    },
    keymap = {
      hover = "H",
      definition = "gd",
      rename = "<leader>rn",
      references = "gr",
      format = "<leader>gf",
    },
    codeRunner = {
      enabled = true,
      ft_runners = {
        bash = "slime",
      },
      default_method = "molten",
    },
  }

  local runner = require "quarto.runner"
  vim.keymap.set("n", "<localleader>rc", runner.run_cell, { desc = "run cell", silent = true })
  vim.keymap.set("n", "<localleader>ra", runner.run_above, { desc = "run cell and above", silent = true })
  vim.keymap.set("n", "<localleader>rA", runner.run_all, { desc = "run all cells", silent = true })
  vim.keymap.set("n", "<localleader>rl", runner.run_line, { desc = "run line", silent = true })
  vim.keymap.set("v", "<localleader>r", runner.run_range, { desc = "run visual range", silent = true })
  vim.keymap.set("n", "<localleader>RA", function()
    runner.run_all(true)
  end, { desc = "run all cells of all languages", silent = true })
end

return M
