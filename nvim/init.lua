require("user.launch")
require("user.options")
require("user.keymaps")
require("user.autocmds")

-- TODO need to make prettier work anyway !!!
-- Plugin("filetype.prettier")  
Plugin("filetype.markdown")
Plugin("filetype.nest")
Plugin("ai")
Plugin("autopairs")
Plugin("cmp")
Plugin("colorizer")
Plugin("colorscheme") -- theme
Plugin("comment")
Plugin("copilot")
Plugin("faster")
Plugin("git")
Plugin("glance")
Plugin("illuminate")
Plugin("indentline")
Plugin("lspconfig") -- TODO needs refactor
Plugin("lualine")
Plugin("marks")
Plugin("mason")
Plugin("neo-tree")
Plugin("noice")
Plugin("notify")
Plugin("null-ls")
Plugin("telescope")
Plugin("tmux")
Plugin("transparent") -- theme
Plugin("treesitter")
Plugin("ufo")
Plugin("whichkey") -- I was wrong, this is very essencial

require("user.lazy")
