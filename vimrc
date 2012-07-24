"  Vim Configuration
"
"  author: Max(max.c.lv@gmail.com)
"  website: http://www.madeye.cn
"  date: 2010-4-12
"  Thanks to: feelinglucky<i.feelinglucky@gmail.com>
"
"  This configuration works well for  C, C++, CUDA and python 

set linebreak
set textwidth=80
set nocompatible
set history=400
set ruler
set number
set hlsearch
set noincsearch
set expandtab
set noerrorbells
set novisualbell
set t_vb= "close visual bell
set foldmethod=marker
set tabstop=4
set shiftwidth=4
set nobackup
set nowritebackup
"set noswapfile
set smarttab
set smartindent
set autoindent
set cindent
set wrap
set autoread
set cmdheight=1
set showtabline=2 
"set clipboard+=unnamed
set tabpagemax=20
set laststatus=2

" make sure sytanx on
if exists("syntax_on")
    syntax reset
else
    syntax on 
endif

winpos 100 100
filetype plugin on

let g:pydiction_location = '~/.vim/after/ftplugin/complete-dict'

function! CurrectDir()
    let curdir = substitute(getcwd(), "", "", "g")
    return curdir
endfunction
set statusline=\ [File]\ %F%m%r%h\ %w\ \ [PWD]\ %r%{CurrectDir()}%h\ \ %=[Line]\ %l,%c\ %=\ %P

if has("multi_byte")
    set encoding=utf-8
    set termencoding=utf-8
    set formatoptions+=mM
    set fencs=utf-8,gbk

    if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
        set ambiwidth=double
    endif

    if has("win32")
        source $VIMRUNTIME/delmenu.vim
        source $VIMRUNTIME/menu.vim
        language messages zh_CN.utf-8
    endif 
else
    echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif

if has("win32")
    set guifont=Courier_New:h12:cANSI
    set guifontwide=YouYuan:h12:cGB2312
    au GUIEnter * simalt ~x
elseif has("mac") || has("macunix")
    set guifont=Courier:h14
    set guifontwide=Hei_Regular:h14
else
    set guifont=
    set guifontwide=
endif

if has("autocmd")
    filetype plugin indent on
    augroup vimrcEx
        au!
        autocmd FileType text setlocal textwidth=78
        autocmd BufReadPost *
                    \ if line("'\"") > 0 && line("'\"") <= line("$") |
                    \   exe "normal g`\"" |
                    \ endif
    augroup END

    function! AutoClose()
        :inoremap ( ()<ESC>i
        :inoremap " ""<ESC>i
        :inoremap ' ''<ESC>i
        :inoremap { {}<ESC>i
        :inoremap [ []<ESC>i
        :inoremap ) <c-r>=ClosePair(')')<CR>
        :inoremap } <c-r>=ClosePair('}')<CR>
        :inoremap ] <c-r>=ClosePair(']')<CR>
    endf

    function! ClosePair(char)
        if getline('.')[col('.') - 1] == a:char
            return "\<Right>"
        else
            return a:char
        endif
    endf

    "auto close for PHP and Javascript script
    au FileType php,c,python,javascript exe AutoClose()
endif

" key stock
map tn :tabnext<cr>
map tp :tabprevious<cr>

"map td :tabnew .<cr>
map td :NERDTree <cr>

map te :tabedit
map tc :tabclose<cr>
map cs :!php -l %<cr>
"map bf :BufExplorer<cr>

set t_Co=256
let g:solarized_termtrans = 0
let g:solarized_termcolors = 256
let g:solarized_contrast = "high"
let g:solarized_degrade = 1
set background=dark
colorscheme solarized

imap jj <ESC>

au BufNewFile,BufRead *.cu set filetype=cuda