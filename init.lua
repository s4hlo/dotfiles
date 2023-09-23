-- Desabilite a compatibilidade com o vi antigo
vim.cmd('set nocompatible')

vim.cmd('set showmatch')

vim.cmd('set ignorecase')

vim.cmd('set mouse=a')

vim.cmd('set hlsearch')

vim.cmd('set autoindent')

vim.cmd('set number')

vim.cmd('set wildmode=longest,list')

-- Configure as colunas de cores para um estilo de codificação limpo
-- vim.cmd('set cc=88')

-- Ativar detecção automática de tipo de arquivo, plugins e indentação
vim.cmd('filetype plugin indent on')

-- Configuração para Lua
vim.cmd('set tabstop=2') -- Use 2 espaços para um caractere de tabulação
vim.cmd('set expandtab') -- Converter tabulações em espaços
vim.cmd('set shiftwidth=2') -- Largura da indentação automática
vim.cmd('set softtabstop=2') -- Use 2 espaços para parar a tecla Tab

-- Mapeamento para retornar ao modo normal pressionando "jj"
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', { noremap = true, silent = true })


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  "github/copilot.vim"
}

require("lazy").setup(plugins, opts)



