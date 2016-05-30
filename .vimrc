let g:syntastic_python_checker="flake8"
let syntastic_python_checker_args="--ignore=E501"
filetype off
set runtimepath+=$GOROOT/misc/vim

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
set shiftwidth=4

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
set ts=4

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

" python-mode config
let g:pymode_doc = 1
let g:pymode_lint = 1
let g:pymode_lint_onfly = 0
let g:pymode_lint_write = 1
let g:pymode_lint_cwindow = 0
let g:pymode_lint_ignore = ""
let g:pymode_lint_checker = "flake8,pyflakes,pep8"
let g:pymode_lint_message = 1
let g:pymode_lint_signs = 1
let g:pymode_folding = 0
let g:pymode_motion = 1
let g:pymode_virtualenv = 0
let g:pymode_indent = 1
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_print_as_function = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all
let g:pymode_syntax_string_formatting = g:pymode_syntax_all
let g:pymode_syntax_string_format = g:pymode_syntax_all
let g:pymode_syntax_string_templates = g:pymode_syntax_all
let g:pymode_syntax_doctests = g:pymode_syntax_all
let g:pymode_syntax_builtin_objs = g:pymode_syntax_all
let g:pymode_syntax_builtin_funcs = g:pymode_syntax_all
let g:pymode_syntax_highlight_exceptions = g:pymode_syntax_all
let g:pymode_syntax_slow_sync = 0

fun! CloseTempBuffer() "{{{
    pclose
endfunction "}}}

let g:current_doc_word = ""
fun! SwitchTempBuffer(word) "{{{
    if g:current_doc_word == a:word
        pclose
        let g:current_doc_word = ""
    else
        let g:current_doc_word = a:word
        call pymode#doc#Show(a:word)
    endif
endfunction "}}}

exe "nnoremap <silent> <buffer> H :call SwitchTempBuffer(expand('<cword>'))<CR>"
exe "vnoremap <silent> <buffer> H :<C-U>call SwitchTempBuffer(@*)<CR>"

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! %!sudo tee > /dev/null %

autocmd FileType go autocmd BufWritePre <buffer> Fmt
