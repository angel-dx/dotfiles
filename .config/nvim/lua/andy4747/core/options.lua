-- Core Neovim options
local opt = vim.opt

-- UI
opt.number = true          -- Show line numbers
opt.relativenumber = true  -- Show relative line numbers
opt.signcolumn = "yes"     -- Always show the signcolumn
opt.cursorline = true      -- Highlight current line
opt.scrolloff = 8          -- Min number of lines to keep above/below cursor
opt.sidescrolloff = 8      -- Min number of columns to keep left/right of cursor
opt.wrap = false           -- Disable line wrap
opt.termguicolors = true   -- True color support
opt.showmode = false       -- Don't show mode in command line
opt.conceallevel = 0       -- Show text normally
opt.list = true            -- Show invisible characters
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Editor
opt.expandtab = true       -- Use spaces instead of tabs
opt.shiftwidth = 2         -- Size of indent
opt.tabstop = 2            -- Number of spaces tabs count for
opt.smartindent = true     -- Insert indents automatically
opt.breakindent = true     -- Wrapped lines respect indentation
opt.ignorecase = true      -- Ignore case when searching
opt.smartcase = true       -- Don't ignore case with capitals
opt.incsearch = true       -- Show search matches as you type
opt.inccommand = "split"   -- Preview substitutions live

-- Buffers
opt.hidden = true          -- Allow hiding buffers with unsaved changes
opt.fillchars = { eob = " " } -- No ~ on empty lines
opt.splitbelow = true      -- Put new windows below current
opt.splitright = true      -- Put new vertical splits to right

-- Files
opt.backup = false         -- Don't keep backup files
opt.swapfile = false       -- Don't create swap files
opt.undofile = true        -- Persistent undo history
opt.undolevels = 10000
opt.updatetime = 200       -- Faster completion

-- System
opt.clipboard = "unnamedplus" -- Use system clipboard
opt.mouse = "a"            -- Enable mouse in all modes
opt.autowrite = true       -- Auto save before commands like :next
opt.confirm = true         -- Confirm changes before closing modified buffers
opt.timeout = true         -- Enable timeout for key sequences
opt.timeoutlen = 300       -- Time to wait for a mapped sequence (ms)
opt.completeopt = "menu,menuone,noselect" -- Completion options

-- Neovim's global statusline (only in >= 0.7)
if vim.fn.has("nvim-0.7") == 1 then
  opt.laststatus = 3
else
  opt.laststatus = 2
end