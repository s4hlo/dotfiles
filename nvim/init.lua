require("user.launch")
require("user.options")
require("user.keymaps")

plugin("filetype.prettier")
plugin("filetype.obsidian")
plugin("filetype.nest")
plugin("filetype.prettier")
plugin("filetype.quarto")

plugin("autopairs") -- TODO try dont use this
plugin("colorizer")
plugin("comment")
plugin("gitsigns")
plugin("glance")
plugin("illuminate")
plugin("indentline")
plugin("lsp-file-ops")
plugin("lualine")
plugin("neo-tree")
plugin("neogit")
plugin("noice")
plugin("notify")
plugin("telescope")
plugin("tmux")
plugin("colorscheme") -- theme
plugin("transparent") -- theme
plugin("whichkey")    -- I was wrong, this is very essencial
plugin("treesitter")

-- lsp and copilot related plugins
-- TODO refactor those plugins
plugin("copilot")
plugin("cmp")
plugin("lspconfig")
plugin("mason")
-- plugin "null-ls" -- TODO figure out the function of this

require("user.lazy")
