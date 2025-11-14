require("user.launch")
require("user.options")
require("user.keymaps")
require("user.autocmds")

Plugin("filetype.markdown")
Plugin("filetype.nest")

Plugin("ai")
Plugin("cmp")
Plugin("colorizer")
Plugin("copilot")
Plugin("lspconfig")
Plugin("mason")
Plugin("transparent")
Plugin("treesitter")
Plugin("illuminate")
Plugin("indentline")

-- solid SRP plugins
Plugin("whichkey")
Plugin("git")
Plugin("colorscheme") 
Plugin("glance")
Plugin("neo-tree")
Plugin("telescope")
Plugin("comment")
Plugin("marks")
Plugin("lualine")
Plugin("ufo")

-- Quality of Life
Plugin("autopairs")
Plugin("faster")
Plugin("noice")
Plugin("notify")
Plugin("tmux")

require("user.lazy")
