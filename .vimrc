" General settings
set nocompatible
set encoding=utf-8
set backspace=indent,eol,start
set history=1000
set undolevels=1000
set clipboard=unnamedplus
" UI and display
set number
set relativenumber
set showcmd
set showmatch
set ruler
set laststatus=2
set wildmenu
set wildmode=longest:full,full
set signcolumn=yes
set cmdheight=2
set updatetime=300
set shortmess+=c

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase

" Indentation and formatting
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set wrap
set linebreak

" File handling
set autoread
set noswapfile
set nobackup
set undofile
set undodir=~/.vim/undo

" Mouse support (nvim-like)
if has('mouse')
    set mouse=a
endif

" Better visual feedback
set visualbell
set noerrorbells

" Performance
set lazyredraw
set ttyfast

" Syntax and colors
syntax enable
set termguicolors
set background=dark
colorscheme desert

" Better cursor highlighting
highlight CursorLine cterm=NONE ctermbg=236 guibg=#2d2d2d
highlight CursorColumn cterm=NONE ctermbg=236 guibg=#2d2d2d
highlight LineNr ctermfg=grey guifg=#5c6370
highlight CursorLineNr cterm=bold ctermfg=yellow guifg=#e5c07b

" Code folding
set foldmethod=syntax
set foldlevelstart=10
set foldnestmax=10

" Key mappings
let mapleader = " "

" Clear search highlighting
nnoremap <leader>h :nohlsearch<CR>

" Quick save and quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>x :x<CR>

" Buffer navigation
nnoremap <leader>n :bnext<CR>
nnoremap <leader>p :bprev<CR>
nnoremap <leader>d :bdelete<CR>

" Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Split windows
nnoremap <leader>v :vsplit<CR>
nnoremap <leader>s :split<CR>

" Move lines up/down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Toggle fold
nnoremap <space> za

" Better indenting
vnoremap < <gv
vnoremap > >gv

" Language-specific settings
autocmd FileType c,cpp setlocal tabstop=8 shiftwidth=8 noexpandtab
autocmd FileType python setlocal tabstop=4 shiftwidth=4 expandtab
autocmd FileType javascript,html,css,json setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType make setlocal tabstop=8 shiftwidth=8 noexpandtab

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/

" Create undo directory if it doesn't exist
if !isdirectory($HOME."/.vim/undo")
    call mkdir($HOME."/.vim/undo", "p", 0700)
endif
" Status line
set statusline=%#PmenuSel#\ %f\ %#LineNr#\ %m%r%h%w\ %=%#CursorColumn#\ %y\ %#PmenuSel#\ %l:%c\ %#LineNr#\ %p%%\
