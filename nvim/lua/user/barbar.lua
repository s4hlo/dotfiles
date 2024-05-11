-- ! CODE SMELLS ALERT
local M = {
  "romgrk/barbar.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
    "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  opts = {
    -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
    -- animation = true,
    -- insert_at_start = true,
    -- …etc.
  },
  version = "^1.0.0", -- optional: only update when a new 1.x version is released
}

function M.config()
  require("barbar").setup {
    insert_at_end = true,
    icons = {
      -- Configure the base icons on the bufferline.
      buffer_index = false,
      buffer_number = false,
      button = "",
      -- Enables / disables diagnostic symbols
      diagnostics = {
        [vim.diagnostic.severity.ERROR] = { enabled = true, icon = "ﬀ" },
        [vim.diagnostic.severity.WARN] = { enabled = false },
        [vim.diagnostic.severity.INFO] = { enabled = false },
        [vim.diagnostic.severity.HINT] = { enabled = false },
      },
      filetype = {
        -- Sets the icon's highlight group.
        -- If false, will use nvim-web-devicons colors
        custom_colors = false,

        -- Requires `nvim-web-devicons` if `true`
        enabled = true,
      },
      separator = { left = "", right = "" },

      -- Configure the icons on the bufferline when modified or pinned.
      -- Supports all the base icon options.
      modified = { button = "●" },
      pinned = { buffer_index = true, filename = true, button = "", separator = { right = "", left = "" } },

      -- Configure the icons on the bufferline based on the visibility of a buffer.
      -- Supports all the base icon options, plus `modified` and `pinned`.
      alternate = { filetype = { enabled = false } },
      current = { buffer_index = false },
      inactive = { button = "", separator = { left = "", right = "" } },
      visible = { modified = { buffer_number = false } },
    },
    sidebar_filetypes = {
      NvimTree = true,
      undotree = { text = "undotree" },
      ["neo-tree"] = { event = "BufWipeout" },
      Outline = { event = "BufWinLeave", text = "symbols-outline" },
    },
    highlight_visible = false,
  }
end

return M
