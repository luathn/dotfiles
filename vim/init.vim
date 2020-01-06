"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins                                                                     "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
" Main plugin
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'easymotion/vim-easymotion'
Plug 'kana/vim-textobj-user'
Plug 'christoomey/vim-tmux-navigator'
" For Rails
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'neoclide/coc-solargraph', {'do': 'yarn install --frozen-lockfile'}
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'tpope/vim-endwise'
" For Python
Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}
" Frontend
Plug 'pangloss/vim-javascript'
" UI
Plug 'vim-airline/vim-airline'
Plug 'morhetz/gruvbox'
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General configs                                                             "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=UTF-8
set history=500
set mouse=a
set noswapfile
set backspace=indent,eol,start
set whichwrap+=<,>,h,l
set autoread                  " Set to auto read when a file is changed
set clipboard=unnamed         " Use the OS clipboard by default
set hid                       " A buffer becomes hidden when it is abandoned
filetype indent on            " Enable filetype plugins
filetype plugin on
syntax enable
set autoindent                " Auto-indent new lines
set expandtab                 " Use spaces instead of tabs
set shiftwidth=2              " Number of auto-indent spaces
set smartindent               " Enable smart-indent
set smarttab                  " Enable smart-tabs
set softtabstop=2             " Number of spaces per Tab
set foldmethod=indent         " Fold based on indent
set foldnestmax=5             " Deepest fold is 5 levels
set nofoldenable              " No fold when start
set splitbelow                " Split below
set splitright                " Split right
set number relativenumber     " turn hybrid line numbers on
set cursorline                " Highlight cursorline
set hlsearch                  " Highlight all search results
set smartcase                 " Enable smart-case search
set ignorecase                " Always case-insensitive
set incsearch                 " Searches for strings incrementally
set so=7                      " Set 7 lines to the cursor
set laststatus=2
set ruler
set wildmenu

if (has("termguicolors"))
  set termguicolors
endif

" Scheme
colorscheme base16-default-dark
let g:gruvbox_contrast_dark='hard'
set background=dark

" Enable matchit for ruby textobject
runtime macros/matchit.vim

" Autocmd
au FocusGained,BufEnter * :checktime
autocmd TermOpen * setlocal nonumber norelativenumber

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings                                                                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map s <Nop>
let mapleader=" "
imap jk <Esc>

vmap <C-C> "+y
vmap gy "+y
nmap gy "+y
nmap gp "+p

nmap ]<space> o<esc>
nmap [<space> O<esc>

" Turn off search highlight
map <silent> <leader><cr> :noh<cr>

" Split windows
map <leader>sv <C-W>v
map <leader>ss <C-W>s

" Buffer
map <leader>xx :Bclose<cr>:tabclose<cr>gT
map <leader>xa :call CloseAllBuffersExceptCurrent()<cr>
map <leader>n :bnext<cr>
map <leader>p :bprevious<cr>

" Mappings for managing tabs
map <leader>tc :tabnew<cr>
map <leader>tx :tabclose<cr>
map <leader>tn :tabnext<cr>
map <leader>tm :tabmove
map <leader>to :tabonly<cr>
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/
" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>"

" NERDTree
map <leader>tt :NERDTreeToggle<cr>
map <leader>tb :NERDTreeFromBookmark<Space>
map <leader>tf :NERDTreeFind<cr>
map <leader>tr :NERDTreeRefreshRoot<cr>

" Ack
nnoremap <leader>a :Ack!<Space>

" Fzf
nnoremap <silent> <c-p> :Files<cr>
nnoremap <silent> <leader>l :Buffers<cr>

" others
map <leader>= :ALEFix<cr>
map s <Plug>(easymotion-prefix)
autocmd Filetype ruby map <leader>r :!ruby %<cr>
autocmd Filetype python map <leader>r :!python3 %<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin config                                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
let g:ack_mappings = {
      \ 'h': '<C-W>k<C-W>l<C-W>l<C-W>s<C-W>j<CR>',
      \ 'v': '<C-W><CR><C-W>L<C-W>p<C-W>J<C-W>p',
      \ 'gv': '<C-W><CR><C-W>L<C-W>p<C-W>J',
      \ 'q': '<C-W>p' }

" Airline config
let g:airline_theme='base16_default'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tabs = 0
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#ale#enabled = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

" NERDTree
let g:NERDTreeMouseMode=3
let NERDTreeShowHidden=1
let NERDTreeIgnore=['.git']
let g:NERDTreeMapJumpPrevSibling=""
let g:NERDTreeMapJumpNextSibling=""
let NERDTreeMapOpenSplit='s'
let NERDTreeMapOpenVSplit='v'

" Coc.nvim setting
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Fzf
let $FZF_DEFAULT_OPTS .= '--inline-info'
let g:fzf_layout = { 'down': '~30%' }

autocmd! FileType fzf tnoremap <buffer> <esc> <c-c>
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit' }

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Ale plugin
let b:ale_linters = ['flake8', 'pylint']
let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'python': ['yapf', 'flake8'],
      \ 'ruby': ['rubocop'],
      \ 'javascript': ['eslint'],
      \ 'css': ['prettier'],
      \ 'json': ['prettier'],
      \ 'yaml': ['prettier'],
      \}

" Function
" Don't close window when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
  let l:currentBufNum = bufnr("%")
  let l:alternateBufNum = bufnr("#")

  if buflisted(l:alternateBufNum)
    buffer #
  else
    bnext
  endif

  if bufnr("%") == l:currentBufNum
    new
  endif

  if buflisted(l:currentBufNum)
    execute("bdelete! ".l:currentBufNum)
  endif
endfunction

function! CloseAllBuffersExceptCurrent()
  let currentBuffer = bufnr("%")
  let lastBuffer = bufnr("$")

  if currentBuffer > 1 | silent! execute "1,".(currentBuffer-1)."bd" | endif
  if currentBuffer < lastBuffer | silent! execute (currentBuffer+1).",".lastBuffer."bd" | endif
endfunction
