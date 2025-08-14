vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable netrw (use native file explorer or replace with telescope)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Basic Settings
local opt = vim.opt

-- UI Settings
opt.number = true
opt.relativenumber = true
opt.signcolumn = 'yes'
opt.cursorline = true
opt.termguicolors = true
opt.showmode = false
opt.laststatus = 3 -- Global statusline
opt.cmdheight = 1
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Editor behavior
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.autoindent = true
opt.smartindent = true
opt.wrap = false
opt.linebreak = true
opt.breakindent = true

-- Search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- File handling
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.undofile = true
opt.undodir = vim.fn.expand('~/.config/nvim/undo')

-- Performance
opt.updatetime = 250
opt.timeoutlen = 300
opt.redrawtime = 10000
opt.synmaxcol = 240

-- Completion
opt.completeopt = {'menu', 'menuone', 'noselect'}
opt.pumheight = 10

-- Split behavior
opt.splitright = true
opt.splitbelow = true

-- Folding (using new 0.11 improvements)
opt.foldmethod = 'expr'
opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
opt.foldlevel = 99
opt.foldtext = ''

-- Mouse and clipboard
opt.mouse = 'a'
opt.clipboard = 'unnamedplus'

-- Filetype detection
vim.filetype.add({
  extension = {
    conf = 'config',
    env = 'config',
  },
  filename = {
    ['.env'] = 'config',
  },
  pattern = {
    ['%.env%..*'] = 'config',
  },
})

-- Autocommands
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
  group = 'YankHighlight',
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 200 })
  end,
})

-- Auto-resize splits when window is resized
augroup('ResizeSplits', { clear = true })
autocmd('VimResized', {
  group = 'ResizeSplits',
  command = 'wincmd =',
})

-- Remove trailing whitespace on save
augroup('TrimWhitespace', { clear = true })
autocmd('BufWritePre', {
  group = 'TrimWhitespace',
  command = '%s/\\s\\+$//e',
})

-- Return to last position when opening files
augroup('RestoreCursor', { clear = true })
autocmd('BufReadPost', {
  group = 'RestoreCursor',
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    if mark[1] > 1 and mark[1] <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

-- Native completion setup (Neovim 0.11 improvements)
-- This uses the built-in completion engine
autocmd('InsertEnter', {
  callback = function()
    -- Enable completion
    vim.opt_local.complete = '.,w,b,u,t,i,kspell'
    vim.opt_local.completeopt = 'menu,menuone,noselect'
  end,
})

