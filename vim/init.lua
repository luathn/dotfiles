vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- General
vim.opt.undofile = true -- Save undo history
vim.opt.updatetime = 100
vim.api.nvim_command("set whichwrap+=<,>,h,l")
vim.schedule(function() vim.opt.clipboard = 'unnamedplus' end) -- Use the OS clipboard by default

-- UI
vim.o.number = true
vim.o.relativenumber = true
vim.opt.signcolumn = 'yes' -- Keep signcolumn on by default
vim.opt.cursorline = true  -- Show which line your cursor is on
vim.opt.scrolloff = 10     -- Minimal number of screen lines to keep above and below the cursor.
vim.opt.breakindent = true -- Enable break indent
vim.o.fillchars = "eob: "  -- Hide eob char ~
-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Indent
vim.o.expandtab = true   -- Use spaces instead of tabs
vim.o.shiftwidth = 2     -- Number of auto-indent spaces
vim.o.softtabstop = 2    -- Number of spaces per Tab
vim.o.smartindent = true -- Enable smart-indent

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.opt.inccommand = 'split' -- Preview substitutions live, as you type!

-- Completion
vim.o.completeopt = "menu,menuone,noselect" -- Set completeopt to have a better completion experience
vim.api.nvim_command("set shortmess+=c")

-- Folding
-- vim.o.foldmethod = "indent"
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldnestmax = 5
vim.o.foldenable = false
vim.o.foldopen = ""
vim.o.foldclose = ""

-- Deprecated
-- vim.o.mouse = "a"
-- vim.o.splitbelow = true
-- vim.o.splitright = true

require("core.llm")
require("pack")
require("core.utils").load_mappings("general")
require("core.utils").load_mappings("term")

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "ruby" },
  command = [[nnoremap <buffer> <leader>rr :term ruby %<CR>]]
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go" },
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "<leader>rr", ":sp | term go run %<CR>", { noremap = true, silent = true })
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function() vim.hl.hl_op() end,
})

vim.api.nvim_create_autocmd("TextPutPost", {
  callback = function() vim.hl.hl_op() end,
})
