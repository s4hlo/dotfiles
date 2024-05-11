local M = {
  "navarasu/onedark.nvim",
  lazy = false,
  priority = 1000,
}

M.config = function()
  require("onedark").setup {
    style = "cool",
  }
  vim.cmd.colorscheme "onedark"
end

return M
