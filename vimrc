" some features must focus consider file type
filetype plugin on
filetype indent on

" Nop, we don't want to be vi-compatible
set nocompatible

" load pathogen
source ~/.vim/plugins/pathogen/autoload/pathogen.vim

" load plugins through pathogen
call pathogen#infect('plugins/{}')

" microsoft products never adhere to any standards
set t_SL=[d
set t_SR=[c
set t_CU=Oa
set t_Cu=[A
set t_CD=Ob
set t_Cd=[B
set t_CL=Od
set t_CR=Oc
set t_S7=[31~
set t_S8=[32~
set t_S9=[33~
set t_S1=[23$

" set tab behaviour
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

" plugin: LargeFile
let g:LargeFile         = 100 " in megabytes

" plugin: NerdTree
let NERDTreeQuitOnOpen=1
let NERDTreeMapOpenSplit="#"
map <silent> <S-F8>  :NERDTreeFocus<CR>
map <silent> <F8>    :NERDTreeFind<CR>
map <silent> <t_S8>  <S-F8>

" plugin: python-mode
let g:pymode_python = 'python3'
let g:pymode_folding = 0
let g:pymode_doc = 1
"let g:pymode_lint_ignore = "E302"
let g:pymode_lint_cwindow = 0
let g:pymode_rope_complete_on_dot = 0

" do not highlight matching parentheses (too slow)
let loaded_matchparen = 1

" disable mouse entirely
set mouse=

" set shell
set shell=zsh

" handling long lines
set wrap lbr showbreak=>>>\
set textwidth=0
set sidescroll=30
set listchars+=precedes:<,extends:>
" leading/trailing characters for line wraps (:help highlight)
hi NonText term=bold ctermfg=6 gui=bold guifg=Green

" nice split pane management
set winminheight=0
map <C-Up>    <C-W>k<C-W>_zz
map <t_CU>    <C-W>k<C-W>_zz
map <t_Cu>    <t_CU>
map <C-Down>  <C-W>j<C-W>_zz
map <t_CD>    <C-W>j<C-W>_zz
map <t_Cd>    <t_CD>

" backslash is a terrible leader character on german keyboard layout
let mapleader = " "

map <leader>l <C-W>k<C-W>_zz
map <leader>a <C-W>j<C-W>_zz
map <leader>e <C-W>l<C-W>_zz
map <leader>i <C-W>h<C-W>_zz
map <leader>v <C-W>_zz
map <leader>o <C-W>o
map <leader>p :se paste!<cr>"*p:se paste!<cr>
map <leader>q :q<cr>
map <leader>r :e<cr>
map <leader><leader> :CtrlP<cr>

" some interesting ideas found here:
" http://dougblack.io/words/a-good-vimrc.html
colorscheme badwolf
set cursorline
set lazyredraw
set showmatch
set incsearch
nnoremap <leader>i `[v`]

let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

" syntax highlighting
syntax on

" I *never* press F1 intentionally
map <F1>        <ESC>

" Yank to clipboard
noremap Y "*y

" Highlight searches, but allow disabling
set hlsearch
map <silent> <F4>    :noh<CR>

" I wich I could set this to a higher value
set history=10000

" F5 = reload
map <silent> <F5>    :e<CR>zz

" Configure built-in Explorer
" (this is a bit outdated, as I switched to NerdTree)
set wildmenu
set wildignore=*.bak,*.o,*.e,*~

" Navigation when started with multiple files
map <silent> <F2>    :prev<CR>
map <silent> <F3>    :next<CR>

" Do not clutter remote file systems with swap files
set dir=~/.vim/swp/
set viminfo='10,<100,:1000,/1000,@1000,%,n~/.vim/viminfo

" avoid hitting ESC
imap jj <ESC>
map j :up<CR>

" This should actually be mapped for PHP files only
inoremap if<cr> if () {<cr>}<up><right><right><right>
inoremap for<cr> for () {<cr>}<up><right><right><right><right>
inoremap foreach<cr> foreach () {<cr>}<up><right><right><right><right><right><right><right><right>
inoremap fori<cr> for () {<cr>}<up><right><right><right><right>$i = 0; $i < ; $i++<left><left><left><left><left><left>

" What's this???
"au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" Nice status lines
set laststatus=2
function! BufferSize()
    let size=getfsize(bufname("%"))
    let unit="B"
    if size > 1024
        let size=size / 1024
        let unit="KB"
    endif
    if size > 1024
        let size=size / 1024
        let unit="MB"
    endif
    return size.unit
endfunction
set statusline=%f%m%r%h%w%=%L\ lines\ %5{BufferSize()}\ %a\ FORMAT=%-4.4{&ff}\ TYPE=%-6.6Y\ POS=%4l,%-3v\ %3p%%

" Source .vim files when opening files
function! SourceDotVim()
    let path=bufname("%")
    if path !~ "^/"
        let path=getcwd()."/".bufname("%")
    endif
    if !isdirectory(path)
        let path=substitute(path, '/[^/]*$', "/", "")
    endif
    let path=simplify(path)
    while path !~ "^/$"
        if filereadable(path."/.vim.ca")
            "echo "sourcing ".path."/.vim.ca"
            "sleep 2
            execute "source ".path."/.vim.ca"
            break
        endif
        let path=substitute(path, '/[^/]*/$', "/", "")
    endwhile
endfunction

if !exists("autocommands_loaded")
    let autocommands_loaded = 1
    autocmd BufNewFile,BufReadPre * call SourceDotVim()
endif

" Fixes the damn backspace problem
if &term == "xterm-color"
    set t_kb=
    fixdel
endif

function! Random()
    if !exists("s:seeded")
        call libcallnr("libc.so.6", "srand", localtime() )
        let s:seeded = 1
    endif
    return libcallnr("libc.so.6", "rand", 0 ) % 65536
endfun

au BufNewFile,BufRead *.jinja2 setlocal ft=jinja

" Some ancient highlight definitions
"hi User1  term=bold  cterm=bold  gui=bold  ctermfg=Black  ctermbg=White  guifg=Black  guibg=White
"hi User2  term=bold  cterm=bold  gui=bold  ctermfg=Red    ctermbg=Black  guifg=Black  guibg=Red

