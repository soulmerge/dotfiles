" some features must consider file type
filetype plugin on
filetype indent on

" Nope, we don't want to be vi-compatible
set nocompatible

" I like the default behaviour of cindent
set cindent

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
let g:LargeFile = 100 " in megabytes

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
let g:pymode_lint_ignore = "E711,E712"
" let g:pymode_lint_ignore = "E711,E301"
let g:pymode_lint_cwindow = 0
let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'mccabe']
let g:pymode_rope = 0
let g:pymode_rope_lookup_project = 0
let g:pymode_rope_completion = 0
let g:pymode_rope_organize_imports_bind = '<leader>I'
" let g:pymode_rope_autoimport_bind = '<leader>i'

" plugin: syntastic
let g:syntastic_cpp_compiler_options = '-std=c++11'
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint', 'jshint']
let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "active_filetypes": ["javascript", "php"],
    \ "passive_filetypes": [] }

" plugin: ale
let g:ale_linters = {
\   'typescript': ['eslint', 'tslint', 'tsserver'],
\}
let g:ale_pattern_options = {
\   '.*\.py$': {'ale_enabled': 0},
\}
"   'python': ['autopep8', 'flake8', isort, mypy, prospector, pycodestyle, pyls, pylint !!, yapf],
let g:ale_sign_column_always = 1
let g:ale_set_highlights = 0
let g:ale_lint_delay = 250

let g:ale_python_flake8_executable = 'python3'
let g:ale_python_pylint_executable = 'pylint'

nnoremap <leader>aa :ALELint<cr>
nnoremap <leader>ar :ALEStopAllLSPs<cr>:ALELint<cr>
nnoremap <leader>ad :ALEDetail<cr>

" do not highlight matching parentheses (too slow)
" let loaded_matchparen = 1

" disable mouse entirely
set mouse=

" move line upwards/downwards
" (https://github.com/mhinz/vim-galore)
nnoremap <leader><up>   :<c-u>execute 'move -1-'. v:count1<cr>
nnoremap <leader><down> :<c-u>execute 'move +'. v:count1<cr>

" set shell
set shell=zsh

" handling long lines
set wrap lbr showbreak=>>>\ 
set textwidth=0
set sidescroll=30
set listchars+=precedes:<,extends:>

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
map <leader>s :split<cr>
map <leader>v <C-W>_zz
map <leader>o <C-W>o
map <leader>c <C-W><C-C>
map <leader>p :se paste!<cr>"*p:se paste!<cr>
map <leader>q :q<cr>
map <leader>r :e<cr>
map <leader><leader> :CtrlP<cr>

" some interesting ideas found here:
" http://dougblack.io/words/a-good-vimrc.html
" set cursorline
set lazyredraw
set showmatch
set incsearch

let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --ignore _cache -g ""'

" colors!
augroup ColorOverride
    au!
    " autocmd ColorScheme * highlight Normal ctermbg=0
    autocmd ColorScheme * highlight StatusLine ctermfg=12 ctermbg=10
    autocmd ColorScheme * highlight StatusLineNC ctermfg=14 ctermbg=8
    " leading/trailing characters for line wraps (:help highlight)
    autocmd ColorScheme * highlight NonText term=bold ctermfg=4
    " autocmd ColorScheme * highlight Search ctermbg=1
    " autocmd ColorScheme * highlight IncSearch ctermbg=3
augroup END

" colorscheme antares
set t_Co=256
colorscheme CandyPaper

" syntax highlighting
syntax on

" I *never* press F1 intentionally
map <F1> <ESC>

" Yank to clipboard
noremap Y "*y

" Highlight searches, but allow disabling
set hlsearch
map <silent> <F4>      :noh<CR>
map <silent> <leader>h :noh<CR>

" I wich I could set this to a higher value
set history=10000

" F5 = reload
map <silent> <F5>    :e<CR>zz

" Configure built-in Explorer
set wildmenu
set wildignore=*.bak,*.o,*.e,*~,*/node_modules/*,*/hg/*,*/.git/*
set path+=**

" Do not search in included files and tags
" (manages to recurse into /usr/include somehow)
set complete-=i
set complete-=t

" Navigation when started with multiple files
map <silent> <F2>  :prev<CR>
map <silent> <F3>  :next<CR>

" Do not clutter remote file systems with swap files
set dir=~/.vim/swp/
set viminfo='10,<100,:1000,/1000,@1000,%,n~/.vim/viminfo

" avoid hitting ESC
imap jj <ESC>
map j :up<CR>
imap -- <ESC>
map - :up<CR>

" Implementation of some tips found here
" http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
vmap v            <Plug>(expand_region_expand)
vmap <C-v>        <Plug>(expand_region_shrink)
vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
    \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
omap s :normal vs<CR>

" This should actually be mapped for PHP files only
inoremap if<cr> if () {<cr>}<up><right><right><right>
inoremap for<cr> for () {<cr>}<up><right><right><right><right>
inoremap foreach<cr> foreach () {<cr>}<up><right><right><right><right><right><right><right><right>
inoremap fori<cr> for () {<cr>}<up><right><right><right><right>var i = 0; i < ; i++<left><left><left><left><left>

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
    autocmd BufNewFile,BufRead *.tpl setlocal filetype=php fileencoding=utf8
    autocmd BufNewFile,BufRead *.page setlocal filetype=php fileencoding=utf8
    autocmd BufNewFile,BufRead *.form setlocal filetype=php fileencoding=utf8
    autocmd BufNewFile,BufRead *.i setlocal filetype=cpp fileencoding=utf8
    autocmd BufNewFile,BufRead *.jinja2 setlocal filetype=jinja
endif

" Fixes the damn backspace problem
if &term == "xterm-color"
    set t_kb=
    fixdel
endif

" Sometimes it is convenient to have some random numbers
function! Random()
    if !exists("s:seeded")
        call libcallnr("libc.so.6", "srand", localtime() )
        let s:seeded = 1
    endif
    return libcallnr("libc.so.6", "rand", 0 ) % 65536
endfun

" jirawl
:autocmd BufRead *Projects/worksheets/can* set filetype=jirawl ai

function! InitTurkish()
    " turkish
    imap <leader>tc ç
    imap <leader>tC Ç
    imap <leader>tg ğ
    imap <leader>tG Ğ
    imap <leader>ti ı
    imap <leader>tI İ
    imap <leader>ts ş
    imap <leader>tS Ş
endfun
map <leader>tt :call InitTurkish()<cr>

set guifont=Monospace\ 12

" restore cursor position
" http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"zz
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END
