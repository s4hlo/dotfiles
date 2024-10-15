require("user.launch")
require("user.options")
require("user.keymaps")
require("user.autocmds")

-- Uncomment this as you need support for different filetypes
-- TODO make this ft detection automatic
Plugin("filetype.markdown")
-- Plugin("filetype.molten")
-- Plugin("filetype.obsidian") 
-- Plugin("image") -- rage comment
Plugin("filetype.nest")
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
Plugin("indentline")
Plugin("leetcode")
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
Plugin("whichkey") -- I was wrong, this is very essencial

require("user.lazy")
