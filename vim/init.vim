"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins                                                                     "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.config/nvim/plugged')
" Main plugin
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'justinmk/vim-sneak'
Plug 'kana/vim-textobj-user'
Plug 'christoomey/vim-tmux-navigator'
Plug 'Yggdroot/indentLine'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'vim-test/vim-test'
Plug 'skywind3000/asyncrun.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'AndrewRadev/splitjoin.vim'
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
if (has("nvim"))
  set termguicolors
  set inccommand=nosplit
endif

" Scheme (base16-seti)
colorscheme base16-default-dark
let g:gruvbox_contrast_dark='hard'
set background=dark

" Enable matchit for ruby textobject
runtime macros/matchit.vim

" Autocmd
au FocusGained,BufEnter * :checktime
if has('nvim')
  autocmd TermOpen * setlocal nonumber norelativenumber
end

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings                                                                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=" "
imap jk <Esc>
map 0 ^
nnoremap Y y$
command! Source :source ~/.config/nvim/init.vim

" Close quickfix
autocmd FileType qf nnoremap <buffer> q :cclose<CR>

" Useful saving mapping
noremap <leader>w :w!<cr>
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <Esc>:update<CR>
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Move a line of text using ALT+[jk]
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Copy text to clipboard
vmap <C-C> "+y
vmap gy "+y
nmap gy "+y
nmap gp "+p
nmap gyn :let @+=expand("%:t")<CR>:echo "File name copied"<CR>
nmap gysp :let @+=expand("%:")<CR>:echo "File path copied"<CR>
nmap gylp :let @+=expand("%:p")<CR>:echo "File full path copied"<CR>

nmap <S-Enter> O<esc>
nmap <CR> o<esc>

" Turn off search highlight
map <silent> <leader>/ :noh<cr>

" Split windows
map <leader>sv <C-W>v
map <leader>ss <C-W>s

" Buffer
map <leader>xx :Bclose<cr>
map <leader>xa :call CloseAllBuffersButCurrent()<cr>
map <silent> <leader>l :bnext<cr>
map <silent> <leader>h :bprevious<cr>

" Mappings for managing tabs
map <leader>tc :tabnew<cr>
map <leader>tx :tabclose<cr>
" map <leader>tn :tabnext<cr>
map <leader>tm :tabmove
map <leader>to :tabonly<cr>
let g:lasttab = 1
" nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/
" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>"

" Coc.nvim
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nnoremap <silent> K :call <SID>show_documentation()<CR>

" ALE
map <leader>= :ALEFix<cr>
nmap <silent> [e <Plug>(ale_previous_wrap)
nmap <silent> ]e <Plug>(ale_next_wrap)

" Ack
nnoremap <leader>a :Ack!<Space>
" When you press gv you Ack after the selected text
vnoremap <leader>a :call VisualSelection('gv', '')<CR>

" Fzf
nnoremap <silent> <c-p> :Files<cr>
nnoremap <silent> <leader>b :Buffers<cr>
nnoremap <silent> <leader>fr :Rg<cr>

" Fugitive
nnoremap <silent> <leader>gb :Git blame<cr>
nnoremap <silent> <leader>gs :G<cr>
nnoremap <silent> <leader>gd :Gdiff<cr>
nnoremap <silent> <leader>gh :diffget //2<cr>
nnoremap <silent> <leader>gl :diffget //3<cr>

" YankStack
let g:yankstack_yank_keys = ['y', 'd']
nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste

" Vim Test
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>

" Defx
nnoremap <C-n> :Defx<CR>
nnoremap <silent> <leader>ff :Defx -toggle=0 -search=`expand('%:p')`<CR>

autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
  " Define mappings
  nnoremap <nowait><silent><buffer><expr> c
  \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> x
  \ defx#do_action('move')
  nnoremap <nowait><silent><buffer><expr> d
  \ defx#do_action('remove')
  nnoremap <silent><buffer><expr> p
  \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> r
  \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> K
  \ defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> m
  \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> M
  \ defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> <CR>
  \ defx#is_directory() ?
  \ defx#do_action('open_or_close_tree') :
  \ defx#do_action('drop')
  nnoremap <silent><buffer><expr> o
  \ defx#is_directory() ?
  \ defx#do_action('open_or_close_tree') :
  \ defx#do_action('drop')
  nnoremap <silent><buffer><expr> <2-LeftMouse>
  \ defx#is_directory() ?
  \ defx#do_action('open_or_close_tree') :
  \ defx#do_action('drop')
  nnoremap <silent><buffer><expr> i
  \ defx#do_action('close_tree')
  nnoremap <silent><buffer><expr> l
  \ defx#do_action('open_directory')
  nnoremap <silent><buffer><expr> h
  \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> v
  \ defx#do_action('toggle_select')
  nnoremap <silent><buffer><expr> V
  \ defx#do_action('clear_select_all')
  nnoremap <silent><buffer><expr> *
  \ defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> E
  \ defx#do_action('open', 'vsplit')
  nnoremap <silent><buffer><expr> P
  \ defx#do_action('preview')
  nnoremap <silent><buffer><expr> C
  \ defx#do_action('toggle_columns', 'indent:icon:filename:type:size:time')
  nnoremap <silent><buffer><expr> S
  \ defx#do_action('toggle_sort', 'time')
  nnoremap <silent><buffer><expr> s
  \ defx#do_action('search')
  nnoremap <silent><buffer><expr> !
  \ defx#do_action('execute_command')
  nnoremap <silent><buffer><expr> X
  \ defx#do_action('execute_system')
  nnoremap <nowait><silent><buffer><expr> y
  \ defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> .
  \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> ;
  \ defx#do_action('repeat')
  nnoremap <silent><buffer><expr> ~
  \ defx#do_action('cd')
  nnoremap <silent><buffer><expr> q
  \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> j
  \ line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k
  \ line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> <C-r>
  \ defx#do_action('redraw')
  nnoremap <silent><buffer><expr> <C-g>
  \ defx#do_action('print')
  nnoremap <silent><buffer><expr> cd
  \ defx#do_action('change_vim_cwd')
endfunction

" CtrlSF
let g:ctrlsf_mapping = {
  \ "openb": { "key": "O", "suffix": "<C-w>p" },
  \ "next": "n",
  \ "prev": "N",
  \ "vsplit": "v",
  \ }
nmap     <C-F>f <Plug>CtrlSFPrompt
vmap     <C-F>f <Plug>CtrlSFVwordPath
vmap     <C-F>F <Plug>CtrlSFVwordExec
nmap     <C-F>n <Plug>CtrlSFCwordPath
nmap     <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>

" others
map <silent> <leader><cr> :call OpenFloatTerm()<cr>

autocmd Filetype ruby map <leader>rr :!ruby %<cr>
autocmd Filetype python map <leader>rr :!python3 %<cr>
vnoremap <leader>rw "hy:%s/<C-r>h//g<left><left>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin config                                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlsf_backend = 'rg'
let g:ctrlsf_extra_backend_args = {
    \ 'rg': '--vimgrep --type-not sql --smart-case'
    \ }
let g:ctrlsf_default_view_mode = 'compact'
let g:ctrlsf_auto_focus = {
  \ "at": "start"
  \ }

" Sneak
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1

" Ack
let g:ackprg = "rg --vimgrep --type-not sql --smart-case"
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

" Coc.nvim setting
inoremap <silent><expr> <Tab>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<Tab>" :
  \ coc#refresh()
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<S-Tab>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Fzf
let g:fzf_layout = { 'down': '~30%' }

autocmd! FileType fzf tnoremap <buffer> <esc> <c-c>
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

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" Ale plugin
let g:ale_ruby_rubocop_executable = 'bundle'

let b:ale_linters = {
  \ 'python': ['pylint'],
  \ 'ruby': ['rubocop'],
  \}

let g:ale_fixers = {
  \ '*': ['remove_trailing_lines', 'trim_whitespace'],
  \ 'python': ['black'],
  \ 'ruby': ['rubocop'],
  \}

" Indentline
let g:indentLine_char = '│'
let g:indentLine_fileTypeExclude = ['defx']

" Vim test
let test#strategy = "asyncrun"
let g:asyncrun_open = 10
let g:test#preserve_screen = 1

" Defx
call defx#custom#option('_', {
  \ 'winwidth': 30,
  \ 'split': 'vertical',
  \ 'direction': 'topleft',
  \ 'show_ignored_files': 0,
  \ 'resume': 1,
  \ 'toggle': 1,
  \ 'columns': 'mark:indent:icon:filename',
  \ })

call defx#custom#column('icon', {
  \ 'directory_icon': '',
  \ 'opened_icon': 'ﱮ',
  \ })

call defx#custom#column('mark', {
  \ 'readonly_icon': '',
  \ 'selected_icon': '',
  \ })

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

function! CloseAllBuffersButCurrent()
  let curr = bufnr("%")
  let last = bufnr("$")
  if curr > 1 | silent! execute "1,".(curr-1)."bd" | endif
  if curr < last | silent! execute (curr+1).",".last."bd" | endif
endfunction

function! OpenFloatTerm()
  let height = float2nr((&lines - 2) / 1.7)
  let row = float2nr((&lines - height) / 2)
  let width = float2nr(&columns / 1.7)
  let col = float2nr((&columns - width) / 2)
  " Border Window
  let border_opts = {
    \ 'relative': 'editor',
    \ 'row': row - 1,
    \ 'col': col - 2,
    \ 'width': width + 4,
    \ 'height': height + 2,
    \ 'style': 'minimal'
    \ }
  let border_buf = nvim_create_buf(v:false, v:true)
  let s:border_win = nvim_open_win(border_buf, v:true, border_opts)
  " Main Window
  let opts = {
    \ 'relative': 'editor',
    \ 'row': row,
    \ 'col': col,
    \ 'width': width,
    \ 'height': height,
    \ 'style': 'minimal'
    \ }
  let buf = nvim_create_buf(v:false, v:true)
  let win = nvim_open_win(buf, v:true, opts)
  terminal
  startinsert
  " Hook up TermClose event to close both terminal and border windows
  autocmd TermClose * ++once :bd! | call nvim_win_close(s:border_win, v:true)
endfunction

function! CmdLine(str)
  call feedkeys(":" . a:str)
endfunction

function! VisualSelection(direction, extra_filter) range
  let l:saved_reg = @"
  execute "normal! vgvy"

  let l:pattern = escape(@", "\\/.*'$^~[]")
  let l:pattern = substitute(l:pattern, "\n$", "", "")

  if a:direction == 'gv'
    call CmdLine("Ack '" . l:pattern . "' " )
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction
