require "user.launch"
require "user.options"
require "user.keymaps"

-- plugin "filetype.jdtls"
plugin "filetype.molten"
plugin "filetype.prettier"
plugin "filetype.quarto"
plugin "filetype.jupytext"
-- ESSENCIAL PLUGINS
plugin "autopairs" -- TODO try dont use this 
plugin "colorizer"
plugin "colorscheme" -- theme
plugin "comment"
plugin "gitsigns"
plugin "glance"
plugin "illuminate"
plugin "indentline"
plugin "lsp-file-ops"
plugin "lualine"
plugin "neo-tree"
plugin "neogit"
plugin "noice"
plugin "notify"
plugin "telescope"
plugin "transparent" -- theme

-- lsp and copilot related plugins
-- TODO refactor those plugins
plugin "treesitter"
plugin "copilot-cmp"
plugin "copilot"
plugin "cmp"
plugin "lspconfig"
plugin "mason"
plugin "null-ls" -- TODO figure out the function of this

-- good for organiation but not essencial
plugin "whichkey"

 -- not essential
plugin "project"
plugin "alpha"
plugin "dadbod"

require "user.lazy"
