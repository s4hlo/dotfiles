require "user.config.launch"
require "user.config.options"
require "user.config.keymaps"
require "user.config.autocmds"
spec "user.filetype.jdtls"
spec "user.filetype.prettier"
-- ESSENCIAL PLUGINS
spec "user.autopairs" -- TODO try dont use this 
spec "user.colorizer"
spec "user.colorscheme" -- theme
spec "user.comment"
spec "user.gitsigns"
spec "user.glance"
spec "user.illuminate"
spec "user.indentline"
spec "user.lsp-file-ops"
spec "user.lualine"
spec "user.neo-tree"
spec "user.neogit"
spec "user.noice"
spec "user.notify"
spec "user.telescope"
spec "user.transparent" -- theme

-- lsp and copilot related plugins
-- TODO refactor those plugins
spec "user.treesitter"
spec "user.copilot-cmp"
spec "user.copilot"
spec "user.cmp"
spec "user.lspconfig"
spec "user.mason"
spec "user.null-ls" -- TODO figure out the function of this

-- good for organiation but not essencial
spec "user.whichkey"

 -- not essential
spec "user.project"
spec "user.alpha"

require "user.lazy"
