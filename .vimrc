call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

set nocompatible "not vi-compatible

" GUI options
set background=dark
set statusline=[%n]\ %<%f\ %((%1*%M%*%R%Y)%)\ %=%-19(\Line\ [%4l/%4L]\ \Col\ [%02c%03V]%)\ ascii['%03b']\ %P
highlight StatusLine term=reverse cterm=bold ctermfg=white ctermbg=lightblue gui=bold guifg=white guibg=blue
set ruler
set laststatus=2

" Indent width
set shiftwidth=2

" Force indent plugin
filetype plugin indent on

" Highlight search results
set hlsearch
set incsearch
set showmatch

" Default to paste mode to avoid double-indentation
set paste

" Syntax on (else no highlight on debian)
syntax on

" Transform tabs into spaces
set expandtab

" Set tabs equal to 2 spaces
set ts=2

" Make mouse middle click paste without formatting it.
map <MouseMiddle> <Esc>"*p

" Move Backup Files to ~/.vim/sessions
set backupdir=~/.vim/sessions
set dir=~/.vim/sessions

" Turn off annoying swapfiles
set noswapfile

" Set persistent undo (v7.3 only)
set undodir=~/.vim/undodir
set undofile

" Closetag plugin configuration
autocmd FileType html,htmldjango,htmljinja,eruby,mako let b:closetag_html_style=1
autocmd FileType html,xhtml,xml,htmldjango,htmljinja,eruby,mako source ~/.vim/bundle/closetag/plugin/closetag.vim

" Tagbar plugin configuration
let g:tagbar_usearrows = 1
nnoremap <leader>l :TagbarToggle<CR>
