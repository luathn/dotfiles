"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins                                                                     "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.config/nvim/plugged')
" Main plugin
Plug 'lambdalisue/suda.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'lambdalisue/fern.vim'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'justinmk/vim-sneak'
Plug 'kana/vim-textobj-user'
Plug 'christoomey/vim-tmux-navigator'
" Plug 'maxbrunsfeld/vim-yankstack'
Plug 'vim-test/vim-test'
Plug 'skywind3000/asyncrun.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'AndrewRadev/splitjoin.vim'
" Plug 'ludovicchabant/vim-gutentags'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'metakirby5/codi.vim'
" For Rails
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Frontend
Plug 'pangloss/vim-javascript'
" UI
" Plug 'itchyny/lightline.vim'
" Plug 'mengelbrecht/lightline-bufferline'

"Test
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'glepnir/galaxyline.nvim'
Plug 'akinsho/nvim-bufferline.lua'
Plug 'Yggdroot/indentLine'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'Pocco81/DAPInstall.nvim'
Plug 'rcarriga/nvim-dap-ui'
Plug 'TimUntersberger/neogit'
Plug 'sindrets/diffview.nvim'

" if has('python3')
"   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"   Plug 'deoplete-plugins/deoplete-lsp'
" else
"   Plug 'nvim-lua/completion-nvim'
"   Plug 'steelsojka/completion-buffers'
" endif
" Plug 'tpope/vim-endwise'
" Plug 'vim-airline/vim-airline'
" Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'mileszs/ack.vim'
" Plug 'zackhsi/fzf-tags'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'neoclide/coc-solargraph', {'do': 'yarn install --frozen-lockfile'}
" Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}
" Plug 'dense-analysis/ale'
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General configs                                                             "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:python3_host_prog = '~/.pyenv/versions/neovim3/bin/python'
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
set fillchars=eob:\           " Hide eob char ~

" Scheme (base16-seti)
colorscheme base16-default-dark
set background=dark

" Enable matchit for ruby textobject
runtime macros/matchit.vim

" Autocmd
au FocusGained,BufEnter * :checktime
if has('nvim')
  autocmd TermOpen * setlocal nonumber norelativenumber
end

" <cword> expansion relies on `iskeyword`. This fixes tag jumping.
augroup RubySpecialKeywordCharacters
  autocmd!
  autocmd Filetype ruby setlocal iskeyword+=!
  autocmd Filetype ruby setlocal iskeyword+=?
augroup END

autocmd FileType typescript setlocal tabstop=4 softtabstop=4 shiftwidth=4
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
noremap <leader>fs :update<CR>
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

" Turn off search highlight
map <silent> <leader>/ :noh<cr>

" Split windows
map <leader>wv <C-W>v
map <leader>ws <C-W>s

" Buffer
map <leader>bk :Bclose<cr>
map <leader>bK :call CloseAllBuffersButCurrent()<cr>
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

" others
map <silent> <leader><cr> :call OpenFloatTerm()<cr>
autocmd Filetype ruby map <leader>rr :!ruby %<cr>
autocmd Filetype python map <leader>rr :!python3 %<cr>
vnoremap <leader>rw "hy:%s/<C-r>h//g<left><left>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua require("galaxy-line")
lua require("buffer-line")
lua require("lsp_config")
lua require("treesitter_config")
lua require("telescope_config")
lua require("dap_debug_config")
lua require("neo_git_config")
lua require("diff_view_config")

source ~/dotfiles/vim/config/ctrlsf.vim
source ~/dotfiles/vim/config/fzf.vim
source ~/dotfiles/vim/config/gitfugitive.vim
" source ~/dotfiles/vim/config/yankstack.vim
source ~/dotfiles/vim/config/sneak.vim
source ~/dotfiles/vim/config/asyncrun.vim
source ~/dotfiles/vim/config/vim-test.vim
source ~/dotfiles/vim/config/fern.vim
source ~/dotfiles/vim/config/lightline.vim
source ~/dotfiles/vim/config/nvim-compe.vim
source ~/dotfiles/vim/config/codi.vim
source ~/dotfiles/vim/config/nvim-tree-lua.vim
source ~/dotfiles/vim/config/indentline.vim

source ~/dotfiles/vim/config/function.vim

" if has('python3')
"   source ~/dotfiles/vim/config/deoplete.vim
" else
"   source ~/dotfiles/vim/config/completion-nvim.vim
" endif
" source ~/dotfiles/vim/config/vim-airline.vim
" source ~/dotfiles/vim/config/defx.vim
" source ~/dotfiles/vim/config/ack.vim
" source ~/dotfiles/vim/config/coc-nvim.vim
" source ~/dotfiles/vim/config/fzf-tags.vim
" source ~/dotfiles/vim/config/ale.vim

nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>dr :lua require'dap'.continue()<CR>
nnoremap <silent> <leader>ds :lua require'dap'.disconnect()<CR>
nnoremap <silent> <leader>db :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>dB :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>dp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
" nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>

nnoremap <leader>dk :lua require("dapui").eval(<c-r>=expand("<cword>")<cr>)<CR>
vnoremap <leader>dk :lua require("dapui").eval()<CR>

:lua << EOF
local dap_install = require("dap-install")

dap_install.setup({
	installation_path = ".dapinstall",
	verbosely_call_debuggers = true,
})
EOF
