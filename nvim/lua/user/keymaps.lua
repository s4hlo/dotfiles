local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
keymap("n", "<C-Space>", "<cmd>WhichKey \\<space><cr>", opts)

-- glance
keymap("n", "gD", "<CMD>Glance definitions<CR>")
keymap("n", "gd", "<CMD>Glance references<CR>")
keymap("n", "gt", "<CMD>Glance type_definitions<CR>")
keymap("n", "gM", "<CMD>Glance implementations<CR>")

-- Better window navigation
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

-- THIS IS THE MOST IMPORT REMAP THAT I'VE EVER DONE
keymap("i", "jj", "<Esc>", opts)
