-- Key Mappings
local keymap = vim.keymap.set

-- Better escape
keymap('i', 'jk', '<Esc>')

-- Clear search highlighting
keymap('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Better navigation
keymap('n', 'j', 'gj')
keymap('n', 'k', 'gk')

-- Window navigation
keymap('n', '<C-h>', '<C-w>h')
keymap('n', '<C-j>', '<C-w>j')
keymap('n', '<C-k>', '<C-w>k')
keymap('n', '<C-l>', '<C-w>l')

-- Window resizing
keymap('n', '<C-Up>', '<cmd>resize +2<CR>')
keymap('n', '<C-Down>', '<cmd>resize -2<CR>')
keymap('n', '<C-Left>', '<cmd>vertical resize -2<CR>')
keymap('n', '<C-Right>', '<cmd>vertical resize +2<CR>')

-- Buffer navigation
keymap('n', '<S-h>', '<cmd>bprevious<CR>')
keymap('n', '<S-l>', '<cmd>bnext<CR>')
keymap('n', '<leader>bd', '<cmd>bdelete<CR>')

-- Better indenting
keymap('v', '<', '<gv')
keymap('v', '>', '>gv')

-- Move lines
keymap('n', '<A-j>', '<cmd>m .+1<CR>==')
keymap('n', '<A-k>', '<cmd>m .-2<CR>==')
keymap('v', '<A-j>', ":m '>+1<CR>gv=gv")
keymap('v', '<A-k>', ":m '<-2<CR>gv=gv")

-- File operations
keymap('n', '<leader>w', '<cmd>write<CR>')
keymap('n', '<leader>q', '<cmd>quit<CR>')
keymap('n', '<leader>Q', '<cmd>qall<CR>')

-- Split management
keymap('n', '<leader>sv', '<cmd>vsplit<CR>')
keymap('n', '<leader>sh', '<cmd>split<CR>')
keymap('n', '<leader>se', '<C-w>=')
keymap('n', '<leader>sx', '<cmd>close<CR>')

-- Terminal
keymap('n', '<leader>tt', '<cmd>split | terminal<CR>')
keymap('t', '<Esc>', '<C-\\><C-n>')

-- File explorer (using native netrw alternative)
keymap('n', '<leader>e', '<cmd>Explore<CR>')


