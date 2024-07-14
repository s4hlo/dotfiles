require "user.config.launch"
-- require "user.config.options"
require "user.config.keymaps"
-- require "user.config.autocmds"
-- spec "plugins.filetype.jdtls"
spec "plugins.filetype.molten"
spec "plugins.filetype.prettier"
spec "plugins.filetype.quarto"
spec "plugins.filetype.jupytext"
-- ESSENCIAL PLUGINS
spec "plugins.autopairs" -- TODO try dont use this 
spec "plugins.colorizer"
spec "plugins.colorscheme" -- theme
spec "plugins.comment"
spec "plugins.gitsigns"
spec "plugins.glance"
spec "plugins.illuminate"
spec "plugins.indentline"
spec "plugins.lsp-file-ops"
spec "plugins.lualine"
spec "plugins.neo-tree"
spec "plugins.neogit"
spec "plugins.noice"
spec "plugins.notify"
spec "plugins.telescope"
spec "plugins.transparent" -- theme

-- lsp and copilot related plugins
-- TODO refactor those plugins
spec "plugins.treesitter"
spec "plugins.copilot-cmp"
spec "plugins.copilot"
spec "plugins.cmp"
spec "plugins.lspconfig"
spec "plugins.mason"
spec "plugins.null-ls" -- TODO figure out the function of this

-- good for organiation but not essencial
spec "plugins.whichkey"

 -- not essential
spec "plugins.project"
spec "plugins.alpha"

require "user.lazy"
