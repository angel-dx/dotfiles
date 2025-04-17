-- Core Neovim options
local opt = vim.opt

-- UI
opt.number = true          -- Show line numbers
opt.relativenumber = true  -- Show relative line numbers
opt.cursorline = true      -- Highlight current line
opt.scrolloff = 10          -- Min number of lines to keep above/below cursor
opt.wrap = false           -- Disable line wrap
opt.termguicolors = true   -- True color support

-- Editor
opt.expandtab = true       -- Use spaces instead of tabs
opt.shiftwidth = 2         -- Size of indent
opt.tabstop = 2            -- Number of spaces tabs count for
opt.softtabstop = 2
opt.smartindent = true     -- Insert indents automatically
opt.breakindent = true     -- Wrapped lines respect indentation
opt.ignorecase = true      -- Ignore case when searching
opt.smartcase = true       -- Don't ignore case with capitals


-- Buffers
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
opt.timeoutlen = 300       -- Time to wait for a mapped sequence (ms)
