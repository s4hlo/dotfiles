local M = {
  "nvim-lualine/lualine.nvim",
  commit = "7533b0ead663d80452210c0c089e5105089697e5",
  dependencies = {
    { "AndreM222/copilot-lualine" },
  },
}

function M.config()
  local sl_hl = vim.api.nvim_get_hl_by_name("StatusLine", true)
  vim.api.nvim_set_hl(0, "Copilot", { fg = "#6CC644", bg = "#3e4452" })
  local icons = require "user.icons"
  local diff = {
    "diff",
    colored = true,
    symbols = { added = icons.git.LineAdded, modified = icons.git.LineModified, removed = icons.git.LineRemoved }, -- Changes the symbols used by the diff.
  }

  local copilot = function()
    local buf_clients = vim.lsp.get_active_clients { bufnr = 0 }
    if #buf_clients == 0 then
      return "LSP Inactive"
    end

    local buf_client_names = {}
    local copilot_active = false

    for _, client in pairs(buf_clients) do
      if client.name ~= "null-ls" and client.name ~= "copilot" then
        table.insert(buf_client_names, client.name)
      end

      if client.name == "copilot" then
        copilot_active = true
      end
    end

    if copilot_active then
      return "%#Copilot#" .. ""
    end
    return ""
  end
  local theme = function()
    local colors = {
      blue = "#61afef",
      green = "#98c379",
      purple = "#c678dd",
      cyan = "#56b6c2",
      red1 = "#e06c75",
      red2 = "#be5046",
      yellow = "#e5c07b",
      fg = "#abb2bf",
      bg = "#282c34",
      gray1 = "#828997",
      gray2 = nil,
      gray3 = "#3e4452",
    }

    return {
      normal = {
        a = { fg = colors.bg, bg = colors.green, gui = "bold" },
        b = { fg = colors.fg, bg = colors.gray3 },
        c = { fg = colors.fg, bg = colors.gray2 },
      },
      command = { a = { fg = colors.bg, bg = colors.yellow, gui = "bold" } },
      insert = { a = { fg = colors.bg, bg = colors.blue, gui = "bold" } },
      visual = { a = { fg = colors.bg, bg = colors.purple, gui = "bold" } },
      terminal = { a = { fg = colors.bg, bg = colors.cyan, gui = "bold" } },
      replace = { a = { fg = colors.bg, bg = colors.red1, gui = "bold" } },
      inactive = {
        a = { fg = colors.gray1, bg = colors.bg, gui = "bold" },
        b = { fg = colors.gray1, bg = colors.bg },
        c = { fg = colors.gray1, bg = colors.gray2 },
      },
    }
  end

  require("lualine").setup {
    options = {
      theme = theme(),
      -- theme = custom_onedark,
      component_separators = { left = "", right = "" },
      -- section_separators = { left = "", right = "" },
      -- component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },

      always_divide_middle = true, -- When set to true, left sections i.e. 'a','b' and 'c'
      -- can't take over the entire statusline even
      -- if neither of 'x', 'y' or 'z' are present.

      ignore_focus = {},
    },

    sections = {
      lualine_a = { "mode" },
      lualine_b = { "filename" },
      lualine_c = { "diff" },
      lualine_y = {
        { "filetype", icon_only = true },
        {
          "copilot",
          show_colors = true,
        },
      },
      lualine_x = {
        "diagnostics",
      },
      lualine_z = { "progress" },
    },
    extensions = { "quickfix", "man", "fugitive" },
  }
end

return M
