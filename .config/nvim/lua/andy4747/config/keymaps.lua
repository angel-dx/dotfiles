local vim_map = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Move lines
vim.api.nvim_set_keymap("n", "<A-j>", "<cmd>m .+1<CR>==", {desc = "Move line down"})
vim.api.nvim_set_keymap("n", "<A-k>", "<cmd>m .-2<CR>==", {desc = "Move line up"})
vim.api.nvim_set_keymap("i", "<A-j>", "<Esc><cmd>m .+1<CR>==gi", {desc = "Move line down"})
vim.api.nvim_set_keymap("i", "<A-k>", "<Esc><cmd>m .-2<CR>==gi", {desc = "Move line up"})
vim.api.nvim_set_keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", {desc = "Move selection down"})
vim.api.nvim_set_keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", {desc = "Move selection up"})

-- Save file with leader
vim.api.nvim_set_keymap("i", "<leader>w", "<Esc><cmd>w<CR>", {desc = "Save file"})
vim.api.nvim_set_keymap("v", "<leader>w", "<Esc><cmd>w<CR>", {desc = "Save file"})
vim.api.nvim_set_keymap("n", "<leader>w", "<Esc><cmd>w<CR>", {desc = "Save file"})

-- Disable arrow keys in normal mode
vim.api.nvim_set_keymap("n", "<Up>", "<Nop>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Down>", "<Nop>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Left>", "<Nop>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<Right>", "<Nop>", {noremap = true, silent = true})

-- Disable arrow keys in insert mode
vim.api.nvim_set_keymap("i", "<Up>", "<Nop>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("i", "<Down>", "<Nop>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("i", "<Left>", "<Nop>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("i", "<Right>", "<Nop>", {noremap = true, silent = true})

-- Disable arrow keys in visual mode
vim.api.nvim_set_keymap("v", "<Up>", "<Nop>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("v", "<Down>", "<Nop>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("v", "<Left>", "<Nop>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("v", "<Right>", "<Nop>", {noremap = true, silent = true})
