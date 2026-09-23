local load_keys = require("core.utils").load_keys
local mappings = require("mappings")

-- Builtin
vim.cmd("packadd nvim.undotree") -- Saved at ~/.local/state/nvim/undo
load_keys(mappings.undotree)

vim.cmd("packadd nvim.difftool")

-- Util
vim.pack.add({ "https://github.com/nvim-lua/plenary.nvim" })

-- UI
vim.pack.add({ "https://github.com/catppuccin/nvim" })
require("catppuccin").setup({})
vim.cmd.colorscheme("catppuccin-frappe")

-- Editor
-- Treesitter
vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })
vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" })
require("plugins.treesitter")
vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter-context" })
require("plugins.treesitter-context")
vim.pack.add({ "https://github.com/Wansmer/treesj" })
require("plugins.treesj")
load_keys(mappings.treesj)

-- LSP & completion
vim.pack.add({ "https://github.com/williamboman/mason.nvim" })
require("mason").setup({})

vim.pack.add({ "https://github.com/williamboman/mason-lspconfig.nvim" })
vim.pack.add({ "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" })
vim.pack.add({ "https://github.com/rafamadriz/friendly-snippets" })

vim.pack.add({ "https://github.com/saghen/blink.cmp" })
require("blink.cmp").setup(require("plugins.blink_cmp"))

vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })
require("plugins.nvim-lspconfig")

-- Mini
vim.pack.add({ "https://github.com/echasnovski/mini.surround" })
require("plugins.mini_surround")

-- Git
vim.pack.add({ "https://github.com/sindrets/diffview.nvim" })
load_keys(mappings.diffview)
require("plugins.diffview")

vim.pack.add({ "https://github.com/TimUntersberger/neogit" })
load_keys(mappings.neogit)
require("plugins.neogit")

-- Navigation & UI
vim.pack.add({ "https://github.com/stevearc/oil.nvim" })
load_keys(mappings.oil)
require("plugins.oil")

vim.pack.add({ "https://github.com/folke/snacks.nvim" })
load_keys(mappings.snacks)
require("plugins.snacks")

-- Code tools
vim.pack.add({ "https://github.com/stevearc/conform.nvim" })
require("plugins.conform")

vim.pack.add({ "https://github.com/MagicDuck/grug-far.nvim" })
load_keys(mappings.grug_far)
require("plugins.grug_far")

vim.pack.add({ "https://github.com/vim-test/vim-test" })
load_keys(mappings.vim_test)
require("plugins.vim_test")

-- DAP
vim.pack.add({ "https://github.com/nvim-neotest/nvim-nio" })
vim.pack.add({ "https://github.com/rcarriga/nvim-dap-ui" })
vim.pack.add({ "https://github.com/leoluz/nvim-dap-go" })

vim.pack.add({ "https://github.com/mfussenegger/nvim-dap" })
load_keys(mappings.dap)
require("plugins.dap")

-- AI
vim.pack.add({ "https://github.com/robitx/gp.nvim" })
require("plugins.gp")

vim.pack.add({ "https://github.com/coder/claudecode.nvim" })
load_keys(mappings.claudecode)
require("claudecode").setup(require("plugins.claudecode"))
vim.keymap.set("n", "<leader>a1", function()
  vim.cmd("ClaudeCodeFocus")
  vim.api.nvim_feedkeys("1", "n", false)
  vim.schedule(function() vim.cmd("wincmd p") end)
end)
vim.keymap.set("n", "<leader>a3", function()
  vim.cmd("ClaudeCodeFocus")
  vim.api.nvim_feedkeys("3", "n", false)
  vim.schedule(function() vim.cmd("wincmd p") end)
end)

-- Test
vim.pack.add({ 'https://github.com/nvim-mini/mini-git' })
load_keys(mappings.mini_git)
require('plugins.deprecated.mini_git')

local map_local = vim.schedule_wrap(function(data)
  if not vim.api.nvim_buf_is_valid(data.buf) then return end
  local buf_name = vim.api.nvim_buf_get_name(data.buf)
  if not vim.startswith(buf_name, 'minigit://') then return end
  vim.keymap.set({ 'n' }, 'q', "<Cmd>q<CR>", { buffer = data.buf, desc = 'Quit mini git window' })
  vim.keymap.set({ 'n', 'x' }, '<CR>', "<Cmd>lua MiniGit.show_at_cursor({ split='vertical' })<CR>",
    { buffer = data.buf, desc = 'Show at cursor' })
  vim.keymap.set({ 'n', 'x' }, '<leader>gs', "<Cmd>lua MiniGit.show_diff_source({ split='vertical' })<CR>",
    { buffer = data.buf, desc = 'Show diff source' })
end)
-- Alternative is to map for `User` `MiniGitCommandSplit` event, but
-- it would not trigger when buffer is created with `show_xxx()` functions
vim.api.nvim_create_autocmd('BufNew', { callback = map_local })

vim.keymap.set('x', '<leader>gl', "<Cmd>lua MiniGit.show_range_history({ split='vertical' })<CR>",
  { desc = 'Show range history' })

-- Deprecated
-- vim.pack.add({ 'https://github.com/nvim-mini/mini.pick' })
-- require('plugins.mini_pick')
-- load_keys(mappings.mini_pick)

-- vim.pack.add({ "https://github.com/echasnovski/mini.cursorword" })
-- require("mini.cursorword").setup({ delay = 500 })

-- vim.pack.add({ "https://github.com/echasnovski/mini.indentscope" })
-- require("plugins.mini_indentscope")

-- vim.pack.add({ "https://github.com/echasnovski/mini.statusline" })
-- require("plugins.mini_statusline")

-- vim.pack.add({ "https://github.com/echasnovski/mini.icons" })
-- require("mini.icons").setup()

-- vim.pack.add({'https://github.com/akinsho/git-conflict.nvim'})
-- require('git-conflict').setup()

-- vim.pack.add({ "https://github.com/tpope/vim-fugitive" })
-- load_keys(mappings.vim_fugitive)
