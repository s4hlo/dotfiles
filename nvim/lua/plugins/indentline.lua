-- local N = {
--   "lukas-reineke/indent-blankline.nvim",
--   event = "VeryLazy",
-- }

local M = { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} }

local highlight = {
  "RainbowBlue",
  "RainbowYellow",
  "RainbowRed",
  "RainbowOrange",
  "RainbowGreen",
  "RainbowViolet",
  "RainbowCyan",
}

function M.config()
  local icons = require "user.icons"

  local hooks = require "ibl.hooks"
  -- create the highlight groups in the highlight setup hook, so they are reset
  -- every time the colorscheme changes
  hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
  end)

  require("ibl").setup {
    indent = {
      -- char = icons.ui.LineLeft,
      char = icons.ui.LineMiddle,
    },
    exclude = {
      filetypes = {
        "help",
        "startify",
        "dashboard",
        "lazy",
        "neogitstatus",
        "Trouble",
        "text",
      },
      buftypes = {
        "terminal",
        "nofile",
      },
    },
    scope = {
      injected_languages = false,
      enabled = true,
      show_end = false,
      show_start = false,
      highlight = highlight,
    },
  }
end

return M
