require("user.launch")
require("user.options")
require("user.keymaps")
require("user.autocmds")

Plugin("filetype.prettier")
Plugin("filetype.obsidian")
Plugin("filetype.nest")
Plugin("filetype.prettier")
Plugin("filetype.molten")

Plugin("autopairs") -- TODO try dont use this
Plugin("colorizer")
Plugin("comment")
Plugin("gitsigns")
Plugin("glance")
Plugin("illuminate")
Plugin("image")
Plugin("indentline")
Plugin("lsp-file-ops")
Plugin("lualine")
Plugin("neo-tree")
Plugin("neogit")
Plugin("noice")
Plugin("notify")
Plugin("telescope")
Plugin("tmux")
Plugin("colorscheme") -- theme
Plugin("transparent") -- theme
Plugin("whichkey") -- I was wrong, this is very essencial
Plugin("treesitter")

-- lsp and copilot related plugins
-- TODO refactor those plugins
Plugin("copilot")
Plugin("cmp")
Plugin("lspconfig")
Plugin("mason")
-- plugin "null-ls" -- TODO figure out the function of this

require("user.lazy")
