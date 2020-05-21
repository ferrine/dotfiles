set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'iamcco/mathjax-support-for-mkdp'
Plugin 'iamcco/markdown-preview.vim'
Plugin 'cohlin/vim-colorschemes'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'lyokha/vim-xkbswitch'
Plugin 'ferrine/md-img-paste.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'LucHermitte/lh-vim-lib'
Plugin 'mhinz/vim-signify'
" all of your plugins must be added before the following line
call vundle#end()            " required

" to ignore plugin indent changes, instead use:
"filetype plugin on
"
" brief help
" :pluginlist       - lists configured plugins
" :plugininstall    - installs plugins; append `!` to update or just :pluginupdate
" :pluginsearch foo - searches for foo; append `!` to refresh local cache
" :pluginclean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for faq
" put your non-plugin stuff after this line

set number                          " line numbers
syntax enable                       " syntax processing
set cursorline                      " highlinght current line
set clipboard=unnamedplus               " clipboard sharing

" Tab settings
set expandtab                       " spaces instead of tabs
set smarttab                        " tab in the beginning of the line acts like shift
set tabstop=4                       " <tab>=n<space>, read mode
set shiftwidth=4                    " the size of an indent
set softtabstop=4                   " <tab>=n<space>, edit mode
set backspace=indent,eol,start      " make backspace work in usual way
" enable filetype detection:
filetype on
filetype plugin on
filetype indent on " file type based indentation

" recognize anything in my .Postponed directory as a news article, and anything
" at all with a .txt extension as being human-language text [this clobbers the
" `help' filetype, but that doesn't seem to prevent help from working
" properly]:
augroup filetype
  autocmd BufNewFile,BufRead */.Postponed/* set filetype=mail
  autocmd BufNewFile,BufRead *.txt set filetype=human
augroup END

autocmd FileType mail set formatoptions+=t textwidth=72 " enable wrapping in mail
autocmd FileType human set formatoptions-=t textwidth=0 " disable wrapping in txt

" for C-like  programming where comments have explicit end
" characters, if starting a new line in the middle of a comment automatically
" insert the comment leader characters:
autocmd FileType c,cpp,java set formatoptions+=ro
autocmd FileType c set omnifunc=ccomplete#Complete

" fixed indentation should be OK for XML and CSS. People have fast internet
" anyway. Indentation set to 2.
autocmd FileType html,xhtml,css,xml,xslt set shiftwidth=2 softtabstop=2

" two space indentation for some files
autocmd FileType vim,lua,nginx set shiftwidth=2 softtabstop=2

" for CSS, also have things in braces indented:
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" add completion for xHTML
autocmd FileType xhtml,html set omnifunc=htmlcomplete#CompleteTags

" add completion for XML
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags

" in makefiles, don't expand tabs to spaces, since actual tab characters are
" needed, and have indentation at 8 chars to be sure that all indents are tabs
" (despite the mappings later):
autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0

" ensure normal tabs in assembly files
" and set to NASM syntax highlighting
autocmd FileType asm set noexpandtab shiftwidth=8 softtabstop=0 syntax=nasm
" End Tab settings
let g:airline_theme = "darcula"
colorscheme py-darcula

set lazyredraw                      " faster macros

set showmatch                       " [{()}]
set matchtime=0                     " remove delay after inserting a closing bracket

set incsearch                       " search as typed
set hlsearch                        " highlight matches

" this will jump to the last known cursor position unless
"   - the position is invalid
"   - the position is inside an event handler
if has("autocmd")
  au bufreadpost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

let mapleader=","                   " <leader> key
" remove highliting with shortcut
nnoremap <leader><space> :nohlsearch<cr>
" folding settings
set foldenable                      " folding (hide some nested code)
set foldlevelstart=10               " 10 folds then are ok
set foldnestmax=10                  " opens max 10 folds
set foldmethod=indent               " python like folds
" space to open/close folds
nnoremap <space> za

set wildmenu                        " visual menu ':
set mouse=a                         " mouse pointing
" mardown preview
let g:mkdp_path_to_chrome="/applications/google\\ chrome.app/contents/macos/google\\ chrome"

function! ToggleMarkdownPreview()
    if b:MarkdownPreviewStatus==0
        :MarkdownPreview
        let b:MarkdownPreviewStatus=1
    else
        :MarkdownPreviewStop
        let b:MarkdownPreviewStatus=0
    endif
endfunction

nmap <silent> <F8> :call ToggleMarkdownPreview()<CR>

" Vim-Markdown
let g:vim_markdown_math = 1         " Used as $x^2$, $$x^2$$, escapable as \$x\$ and \$\$x\$\$

" Keyboard Switcher
let g:XkbSwitchEnabled = 1          " enable lyokha/vim-xkbswitch
" This is platform specific and for macos needs
" https://github.com/vovkasm/input-source-switcher installed
let g:XkbSwitchLib = '/usr/local/lib/libInputSourceSwitcher.dylib'

" Custom remaps
" <leader>(l)<CR> inserts line above(below)
nnoremap <silent><leader>l<CR> :set paste<CR>m`o<Esc>``:set nopaste<CR><C-y>
nnoremap <silent><leader><CR> :set paste<CR>m`O<Esc>``:set nopaste<CR><C-e>

fun! TrimWhitespace()               " Removes all trailing spaces
    " Save position
    normal m`
    " Ramove all trailing spaces
    %s/\s\+$//e
    " Return to saved position 
    normal ``
endfun
" :TrimWhitespace
command! TrimWhitespace call TrimWhitespace()

" http://vim.wikia.com/wiki/Toggle_spellcheck_with_function_keys

let g:myLangList=["nospell","ru_ru","en_us", "ru_ru,en_us"]

function! ToggleSpell()
    let b:myLang=b:myLang+1
    if b:myLang>=len(g:myLangList) | let b:myLang=0 | endif
    if b:myLang==0
        setlocal nospell
    else
        execute "setlocal spell spelllang=".get(g:myLangList, b:myLang)
    endif
    echo "spell checking language:" g:myLangList[b:myLang]
endfunction

nmap <silent> <F12> :call ToggleSpell()<CR>

" custom plugin for markdown that inserts images in a smart way.
" 1. you have image in clipboard
" 2. press <leader>p to copy image to `img/imageN.png` and insert
" `![](img/imageN.png)` into image
autocmd FileType markdown nmap <silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>

" NerdTree configuration
" Open/Close Nerd Tree
map <C-n> :NERDTreeToggle<CR>
" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Open NERDTree automatically when vim starts up on opening a directory
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" Set Buffer specific variables with trigger function
function! SetBufferVariables()
    " For spellchecking
    let b:myLang=index(g:myLangList, &spelllang)
    " For markdown preview toggle
    let b:MarkdownPreviewStatus=0
endfunction
autocmd BufReadPost * call SetBufferVariables()
" write with sudo
cmap w!! w !sudo -S tee > /dev/null %
