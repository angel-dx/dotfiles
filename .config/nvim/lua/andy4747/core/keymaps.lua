-- Core keymaps not related to plugins
local map = vim.keymap.set

-- Better window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Navigate to the left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Navigate to the bottom window" })
map("n", "<C-k>", "<C-w>k", { desc = "Navigate to the top window" })
map("n", "<C-l>", "<C-w>l", { desc = "Navigate to the right window" })

-- Resize windows
map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- Buffer navigation
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })

-- Move lines
map("n", "<A-j>", "<cmd>m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<CR>==", { desc = "Move line up" })
map("i", "<A-j>", "<Esc><cmd>m .+1<CR>==gi", { desc = "Move line down" })
map("i", "<A-k>", "<Esc><cmd>m .-2<CR>==gi", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Stay in indent mode
map("v", "<", "<gv", { desc = "Decrease indent and stay in visual mode" })
map("v", ">", ">gv", { desc = "Increase indent and stay in visual mode" })

-- Clear search with <Esc>
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Save file with leader
map({ "i", "v", "n" }, "<leader>w", "<Esc><cmd>w<CR>", { desc = "Save file" })

-- Exit insert mode
map("i", "jk", "<Esc>", { desc = "Exit insert mode" })
map("i", "kj", "<Esc>", { desc = "Exit insert mode" })

-- Terminal mappings
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Terminal: navigate left" })
map("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Terminal: navigate down" })
map("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Terminal: navigate up" })
map("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Terminal: navigate right" })

-- Misc useful mappings
map("n", "J", "mzJ`z", { desc = "Join lines without moving cursor" })
map("n", "n", "nzzzv", { desc = "Next search result and center" })
map("n", "N", "Nzzzv", { desc = "Previous search result and center" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
map("n", "<leader>Q", "<cmd>qa<CR>", { desc = "Quit all" })