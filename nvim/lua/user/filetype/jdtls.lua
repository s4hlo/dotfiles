local M = {
  "mfussenegger/nvim-jdtls",
}

local config = {
    cmd = { vim.fn.expand('~/.local/share/nvim/mason/bin/jdtls')},
    root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
}

function M.config()
    require('jdtls').start_or_attach(config)
end

return M