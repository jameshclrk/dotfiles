if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

set nocompatible
call plug#begin('~/.vim/plugged')

"
" Must Haves
"

" Better finding
Plug 'easymotion/vim-easymotion'
" ctrl-p file
Plug 'ctrlpvim/ctrlp.vim'
" Automatic tab settings
Plug 'tpope/vim-sleuth'
" Sublime-esque multi cursors
Plug 'terryma/vim-multiple-cursors'

"
" LSP
"

Plug 'w0rp/ale'
let g:ale_fixers = {
  \   '*': ['remove_trailing_lines', 'trim_whitespace'],
  \   'javascript': ['eslint'],
  \   'python': ['black'],
\}
let g:ale_set_balloons = 1
let g:ale_completion_enabled = 1
set mouse=a
set ttymouse=xterm

"
" Languages
"

" Mega language pack
Plug 'sheerun/vim-polyglot'
" Hex editor
Plug 'fidian/hexmode'
" CSV column highlighting
Plug 'chrisbra/csv.vim'
"
" Misc
"

" show VCS diff in gutter
Plug 'mhinz/vim-signify'
" quickly change surroundings - (), '', etc
Plug 'tpope/vim-surround'
" quickly comment out stuff
Plug 'tpope/vim-commentary'
" show indent level
Plug 'yggdroot/indentline'
let g:indentLine_setColors = 0
let g:indentLine_char = '┊'
" Highlight whitespace
Plug 'ntpeters/vim-better-whitespace'
" quickly align things
Plug 'godlygeek/tabular'
" markdown
Plug 'plasticboy/vim-markdown'
" autocomplete quotes, parenthesis, brackets, etc.
Plug 'Raimondi/delimitMate'
" close files and keep layouts
Plug 'moll/vim-bbye'
" Buffers as tabs
Plug 'ap/vim-buftabline'
" better buffer closing
Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }
cnoreabbrev wq w<bar>Sayonara
cnoreabbrev q Sayonara
" Git wrapper
Plug 'tpope/vim-fugitive'
" Git browser
Plug 'junegunn/gv.vim'

" Colour theme
Plug 'rakr/vim-one'
Plug 'dracula/vim', { 'as': 'dracula' }

" writng mode
Plug 'junegunn/goyo.vim'

" Vista
Plug 'liuchengxu/vista.vim'

call plug#end()

set backupdir=~/.vim/tmp//
set directory=~/.vim/tmp//
set undodir=~/.vim/tmp//

hi Pmenu ctermbg=0 ctermfg=8
hi PmenuSel ctermfg=2

filetype plugin indent on
set backspace=indent,eol,start

" full colours
if has("termguicolors")
  set termguicolors
endif
syntax on
colorscheme dracula
" wsl nonsense
set t_ut=

" encoding
set encoding=utf-8
scriptencoding utf-8

" local vimrc
set exrc
set secure

" tab sizes
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" line numbers
set number

" move through wrapped lines
vmap j gj
vmap k gk
nmap j gj
nmap k gk

" easymotion
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)
let g:EasyMotion_smartcase = 1

" Ctrl-P
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" new file in vertical split
nnoremap <c-N> :vnew<CR>

" multi cursor
let g:multi_cursor_use_default_mapping=0
" Default mapping
let g:multi_cursor_next_key='<C-d>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'
" Map start key separately from next key
let g:multi_cursor_start_key='<c-d>'

" next and prev buffer
set hidden
nnoremap <tab> :bnext<CR>
nnoremap <S-tab> :bprev<CR>

let g:vim_markdown_conceal = 0

" F2 to build
map <F2> :w \| make<CR>

