local M = {
  "xiyaowong/transparent.nvim",
}

function M.config()
  require('transparent').clear_prefix('NeoTree')
  require("transparent").setup { -- Optional, you don't have to run setup.
    groups = { -- table: default groups
      "Normal",
      "NormalNC",
      "Comment",
      "Constant",
      "Special",
      "Identifier",
      "Statement",
      "PreProc",
      "Type",
      "Underlined",
      "Todo",
      "String",
      "Function",
      "Conditional",
      "Repeat",
      "Operator",
      "Structure",
      "LineNr",
      "NonText",
      "SignColumn",
      "CursorLine",
      "CursorLineNr",
      "StatusLine",
      "StatusLineNC",
      "EndOfBuffer",
    },
    extra_groups = { -- table/string: additional groups that should be cleared
      "IndentBlanklineChar",
      -- make floating windows transparent
      "LspFloatWinNormal",
      "Normal",
      "Pmenu",
      "Normal:Pmenu",
      "CmpNormal",
      "FloatBorder",
      "Float",
      "NormalFloat",
      "TelescopeNormal",
      "TelescopeBorder",
      "TelescopePromptBorder",
      "SagaBorder",
      "SagaNormal",
      -- glance
      "GlanceWinBarFilename",
      "GlanceWinBarFilepath",
      "GlanceWinBarTitle",
      "GlanceBorderTop",
    },

    -- extra_groups = {
    --   "NormalFloat", -- plugins which have float panel such as Lazy, Mason, LspInfo
    -- },
    exclude_groups = {}, -- table: groups you don't want to clear
  }
end

return M
