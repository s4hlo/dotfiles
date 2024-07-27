require("user.launch")
require("user.options")
require("user.keymaps")
require("user.autocmds")

Plugin("filetype.markdown")
Plugin("filetype.molten")
Plugin("filetype.nest")
Plugin("filetype.obsidian")
Plugin("filetype.prettier")
Plugin("filetype.prettier")

Plugin("autopairs")
Plugin("cmp")
Plugin("colorizer")
Plugin("colorscheme") -- theme
Plugin("comment")
Plugin("copilot")
Plugin("git")
Plugin("glance")
Plugin("illuminate")
Plugin("image")
Plugin("indentline")
Plugin("lsp-file-ops")
Plugin("lspconfig") -- TODO needs refactor
Plugin("lualine")
Plugin("mason")
Plugin("neo-tree")
Plugin("noice")
Plugin("notify")
Plugin("null-ls")
Plugin("telescope")
Plugin("tmux")
Plugin("transparent") -- theme
Plugin("treesitter")
Plugin("whichkey")    -- I was wrong, this is very essencial

require("user.lazy")
