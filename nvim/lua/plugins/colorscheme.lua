return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd.colorscheme("tokyonight")
      -- vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#555566" })
      require("tokyonight").setup({
        transparent = false, -- Enable this to disable setting the background color
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
      })
    end,
  }
}
