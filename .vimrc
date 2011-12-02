set nocompatible "not vi-compatible

" GUI options
set background=dark
set statusline=[%n]\ %<%f\ %((%1*%M%*%R%Y)%)\ %=%-19(\Line\ [%4l/%4L]\ \Col\ [%02c%03V]%)\ ascii['%03b']\ %P
highlight StatusLine term=reverse cterm=bold ctermfg=white ctermbg=lightblue gui=bold guifg=white guibg=blue

" Indent width
set shiftwidth=2

" Force indent plugin
filetype plugin indent on

" Highlight search results
set hlsearch

" Default to paste mode to avoid double-indentation
set paste

" Syntax on (else no highlight on debian)
syntax on

" Transform tabs into spaces
set expandtab

" Set tabs equal to 2 spaces
set ts=2

