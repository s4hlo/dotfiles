local M = {
  "MunifTanjim/prettier.nvim",
}

function M.config()
  require("prettier").setup({
    cli_options = {
      bracket_spacing = false,
    },
    bin = 'prettier', -- or `'prettierd'` (v0.23.3+)
    filetypes = {
      "css",
      "graphql",
      "html",
      "javascript",
      "javascriptreact",
      "json",
      "less",
      "markdown",
      "scss",
      "typescript",
      "typescriptreact",
      "yaml",
    },
  })
end

return M
