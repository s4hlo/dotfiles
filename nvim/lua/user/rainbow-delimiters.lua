local M = {
    "hiphish/rainbow-delimiters.nvim",
    event = "BufReadPost",
}
M.config = function()
  local rainbow_delimiters = require "rainbow-delimiters"
  ---@type rainbow_delimiters.config
  vim.g.rainbow_delimiters = {
    strategy = {
        [''] = rainbow_delimiters.strategy['global'],
        vim = rainbow_delimiters.strategy['local'],

    },
    query = {
        [''] = 'rainbow-delimiters',
        lua = 'rainbow-blocks',
        tsx = 'rainbow-blocks',
        typescript = 'rainbow-blocks',
        javascript = 'rainbow-blocks',
    },
    priority = {
        [''] = 110,
        lua = 210,
        typescript = 1,
    },
    highlight = {
        'RainbowDelimiterRed',
        'RainbowDelimiterYellow',
        'RainbowDelimiterBlue',
        'RainbowDelimiterOrange',
        'RainbowDelimiterGreen',
        'RainbowDelimiterViolet',
        'RainbowDelimiterCyan',
    },
  }
end

return M
