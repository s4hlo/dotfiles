local M = {
  "navarasu/onedark.nvim",
  lazy = false,
  pririty = 1000,
  opts = {
    style = 'warm'
  }
}

function M.config()
  vim.cmd.colorscheme "onedark"
end

return M
