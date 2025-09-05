vim.g.mapleader = " "
vim.g.maplocalleader = " "

--------- Kickstart
-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Use the OS clipboard by default
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

--------- Old

vim.o.encoding = "UTF-8"
vim.opt.updatetime = 100
-- vim.o.history = "500"
vim.o.mouse = "a"
-- vim.o.noswapfile = true
vim.o.backspace = "indent,eol,start"
vim.api.nvim_command("set whichwrap+=<,>,h,l")
-- Set to auto read when a file is changed
vim.o.autoread = true
-- A buffer becomes hidden when it is abandoned
vim.o.hid = true
-- Enable filetype plugins
vim.api.nvim_command("filetype indent on")
vim.api.nvim_command("filetype plugin on")
vim.api.nvim_command("syntax enable")
-- Auto-indent new lines
vim.o.autoindent = true
-- Use spaces instead of tabs
vim.o.expandtab = true
-- Number of auto-indent spaces
vim.o.shiftwidth = 2
-- Enable smart-indent
vim.o.smartindent = true
-- Enable smart-tabs
vim.o.smarttab = true
-- Number of spaces per Tab
vim.o.softtabstop = 2
-- Fold based on indent
vim.o.foldmethod = "indent"
-- Deepest fold is 5 levels
vim.o.foldnestmax = 1
-- No fold when start
vim.o.foldenable = false
vim.o.foldopen = ""
vim.o.foldclose = ""
-- Split below
vim.o.splitbelow = true
-- Split right
vim.o.splitright = true
-- turn hybrid line numbers on
vim.o.number = true
vim.o.relativenumber = true
-- Highlight all search results
vim.o.hlsearch = true
-- Enable smart-case search
vim.o.smartcase = true
-- Always case-insensitive
vim.o.ignorecase = true
-- Searches for strings incrementally
vim.o.incsearch = true
vim.o.laststatus = 2
vim.o.ruler = true
-- vim.o.wildmenu = true
-- vim.o.wildmode = 'full'
-- Hide eob char ~
vim.o.fillchars = "eob: "
-- Set completeopt to have a better completion experience
vim.o.completeopt = "menu,menuone,noselect"
vim.api.nvim_command("set shortmess+=c")
vim.o.showmode = false

if vim.fn.has('nvim-0.12') == 1 then
  vim.o.diffopt = 'internal,filler,closeoff,inline:word,linematch:40'
end
