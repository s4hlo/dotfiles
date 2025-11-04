require("user.launch")
require("user.options")
require("user.keymaps")
require("user.autocmds")

-- Uncomment this as you need support for different filetypes
-- TODO make this ft detection automatic
Plugin("filetype.molten")
-- Plugin("image") -- rage comment
-- Plugin("filetype.obsidian")
Plugin("filetype.markdown")
Plugin("filetype.nest")

-- TODO need to make prettier work anyway !!!
-- Plugin("filetype.prettier")  

-- Plugin("avante")
-- Plugin("dap")
-- Plugin("copilot")

Plugin("transparent") -- theme
Plugin("faster")
Plugin("autopairs")
Plugin("cmp")
Plugin("colorizer")
Plugin("colorscheme") -- theme
Plugin("comment")
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
Plugin("treesitter")
Plugin("ufo")
Plugin("whichkey") -- I was wrong, this is very essencial

require("user.lazy")
