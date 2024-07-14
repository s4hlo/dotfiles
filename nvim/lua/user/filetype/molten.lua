local M = {
    "benlubas/molten-nvim",
    build = ":UpdateRemotePlugins",
    dependencies = {
      '3rd/image.nvim',
      'willothy/wezterm.nvim',
    },
    init = function()
        -- this is an example, not a default. Please see the readme for more configuration options
        vim.g.molten_output_win_max_height = 12
    end,
}

-- function M.config()
--   require("molten").setup {
--   }
-- end

return M
