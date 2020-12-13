runtime plugins.vim
runtime latex.vim
runtime functions.vim
runtime snippets.vim
"Config Section
if (has("termguicolors"))
 set termguicolors
endif
syntax enable
colorscheme dracula

set relativenumber                          " line numbers
set nu rnu
syntax enable                       " syntax processing
set cursorline                      " highlinght current line
set clipboard=unnamedplus               " clipboard sharing
set autochdir
" Tab settings
set expandtab                       " spaces instead of tabs
set smarttab                        " tab in the beginning of the line acts like shift
set tabstop=4                       " <tab>=n<space>, read mode
set shiftwidth=4                    " the size of an indent
set softtabstop=4                   " <tab>=n<space>, edit mode
set backspace=indent,eol,start      " make backspace work in usual way
set termguicolors
" enable filetype detection:
filetype on
filetype plugin on
filetype indent on " file type based indentation
let mapleader=","                   " <leader> key
autocmd FileType markdown nmap <silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd TextChanged,TextChangedI <buffer> silent write
let g:python_host_prog = "/usr/bin/python3"
let g:python3_host_prog = "/usr/bin/python3"
