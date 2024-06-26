local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
keymap("n", "<C-Space>", "<cmd>WhichKey \\<space><cr>", opts)
keymap("n", "<C-i>", "<C-i>", opts)

-- glance
keymap("n", "gD", "<CMD>Glance definitions<CR>")
keymap("n", "gd", "<CMD>Glance references<CR>")
keymap("n", "gY", "<CMD>Glance type_definitions<CR>")
keymap("n", "gM", "<CMD>Glance implementations<CR>")

-- Better window navigation
keymap("n", "<m-h>", "<C-w>h", opts)
keymap("n", "<m-j>", "<C-w>j", opts)
keymap("n", "<m-k>", "<C-w>k", opts)
keymap("n", "<m-l>", "<C-w>l", opts)
keymap("n", "<m-tab>", "<c-6>", opts)
keymap("n", "<A-J>", "<Cmd>BufferMovePrevious<CR>", opts)
keymap("n", "<A-K>", "<Cmd>BufferMoveNext<CR>", opts)
-- keymap('n', 'J', '<Cmd>BufferPrevious<CR>', opts)
-- keymap('n', 'K', '<Cmd>BufferNext<CR>', opts)
-- keymap('n',  '<leader>bd', '<Cmd>BufferClose<CR>', opts)

keymap("n", "J", "<Cmd>bp<CR>", opts)
keymap("n", "K", "<Cmd>bn<CR>", opts)
keymap("n", "<leader>bd", "<Cmd>bd<CR>", opts)

keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
keymap("n", "*", "*zz", opts)
keymap("n", "#", "#zz", opts)
keymap("n", "g*", "g*zz", opts)
keymap("n", "g#", "g#zz", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

keymap("x", "p", [["_dP]])

vim.cmd [[:amenu 10.100 mousemenu.Goto\ Definition <cmd>lua vim.lsp.buf.definition()<CR>]]
vim.cmd [[:amenu 10.110 mousemenu.References <cmd>lua vim.lsp.buf.references()<CR>]]
-- vim.cmd [[:amenu 10.120 mousemenu.-sep- *]]

vim.keymap.set("n", "<RightMouse>", "<cmd>:popup mousemenu<CR>")
vim.keymap.set("n", "<Tab>", "<cmd>:popup mousemenu<CR>")
keymap("i", "jj", "<Esc>", opts)
