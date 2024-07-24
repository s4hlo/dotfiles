return {
  {
    "sindrets/diffview.nvim",
    config = function()
      local actions = require("diffview.actions")
      require("diffview").setup({
        diff_binaries = false,   -- Show diffs for binaries
        enhanced_diff_hl = false, -- See |diffview-config-enhanced_diff_hl|
        git_cmd = { "git" },     -- The git executable followed by default args.
        hg_cmd = { "hg" },       -- The hg executable followed by default args.
        use_icons = true,        -- Requires nvim-web-devicons
        show_help_hints = false,  -- Show hints for how to open the help panel
        watch_index = true,      -- Update views and index buffers when the git index changes.
        keymaps = {
          file_panel = {
            ["gf"] = function()
              actions.goto_file_edit()
              vim.cmd("tabclose #")
            end,
            ["q"] = function()
              vim.cmd("tabclose")
            end,
          },
        },
      })
    end
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufEnter",
    commit = "5a9a6ac29a7805c4783cda21b80a1e361964b3f2",
    cmd = "Gitsigns",
    config = function()
      local icons = require("user.icons")

      require("gitsigns").setup({
        signs = {
          add = {
            hl = "GitSignsAdd",
            text = icons.ui.BoldLineLeft,
            numhl = "GitSignsAddNr",
            linehl = "GitSignsAddLn",
          },
          change = {
            hl = "GitSignsChange",
            text = icons.ui.BoldLineLeft,
            numhl = "GitSignsChangeNr",
            linehl = "GitSignsChangeLn",
          },
          delete = {
            hl = "GitSignsDelete",
            text = icons.ui.TriangleShortArrowRight,
            numhl = "GitSignsDeleteNr",
            linehl = "GitSignsDeleteLn",
          },
          topdelete = {
            hl = "GitSignsDelete",
            text = icons.ui.TriangleShortArrowRight,
            numhl = "GitSignsDeleteNr",
            linehl = "GitSignsDeleteLn",
          },
          changedelete = {
            hl = "GitSignsChange",
            text = icons.ui.BoldLineLeft,
            numhl = "GitSignsChangeNr",
            linehl = "GitSignsChangeLn",
          },
        },
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        update_debounce = 200,
        max_file_length = 40000,
        preview_config = {
          border = "rounded",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
      })
    end
  }
}
