set nocompatible "not vi-compatible

" GUI options
set background=dark
set statusline=[%n]\ %<%f\ %((%1*%M%*%R%Y)%)\ %=%-19(\Line\ [%4l/%4L]\ \Col\ [%02c%03V]%)\ ascii['%03b']\ %P
highlight StatusLine term=reverse cterm=bold ctermfg=white ctermbg=lightblue gui=bold guifg=white guibg=blue

" Indent width
set shiftwidth=2

" Force indent plugin
filetype plugin indent on

set paste
