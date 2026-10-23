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
vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter-context" })
vim.pack.add({ "https://github.com/Wansmer/treesj" })
require("pack.treesitter")
load_keys(mappings.treesj)

-- Completion
vim.pack.add({ "https://github.com/saghen/blink.cmp" })
require("pack.blink_cmp")

-- LSP
vim.pack.add({ "https://github.com/williamboman/mason.nvim" })
vim.pack.add({ "https://github.com/williamboman/mason-lspconfig.nvim" })
vim.pack.add({ "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" })
vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })
require("pack.lsp")

-- Git
vim.pack.add({ "https://github.com/sindrets/diffview.nvim" })
load_keys(mappings.diffview)
require("pack.diffview")

vim.pack.add({ "https://github.com/TimUntersberger/neogit" })
load_keys(mappings.neogit)
require("pack.neogit")

vim.pack.add({ 'https://github.com/nvim-mini/mini-git' })
load_keys(mappings.mini_git)
require('pack.mini_git')

-- Navigation
vim.pack.add({ "https://github.com/stevearc/oil.nvim" })
load_keys(mappings.oil)
require("pack.oil")

vim.pack.add({ "https://github.com/folke/snacks.nvim" })
load_keys(mappings.snacks)
require("pack.snacks")

vim.pack.add({ "https://github.com/MagicDuck/grug-far.nvim" })
load_keys(mappings.grug_far)
require("pack.grug_far")

-- Tools
vim.pack.add({ "https://github.com/echasnovski/mini.surround" })
require("pack.mini_surround")

vim.pack.add({ "https://github.com/vim-test/vim-test" })
load_keys(mappings.vim_test)
require("pack.vim_test")

-- Debug
vim.pack.add({ "https://github.com/nvim-neotest/nvim-nio" })
vim.pack.add({ "https://github.com/rcarriga/nvim-dap-ui" })
vim.pack.add({ "https://github.com/leoluz/nvim-dap-go" })
vim.pack.add({ "https://github.com/mfussenegger/nvim-dap" })
load_keys(mappings.dap)
require("pack.dap")

-- AI
vim.pack.add({ "https://github.com/coder/claudecode.nvim" })
load_keys(mappings.claudecode)
require("pack.claudecode")

-- Test
vim.pack.add({ 'https://github.com/nvim-mini/mini.pick' })
require('pack.deprecated.mini_pick')
load_keys(mappings.mini_pick)

vim.opt.rtp:prepend(vim.fn.expand("~/code/nvimtico"))
vim.g.nvimtico_ui_select = true
vim.keymap.set("n", "<leader><space>", "<cmd>Tico files<cr>")
vim.keymap.set("n", "<leader>,", "<cmd>Tico buffers<cr>")
vim.keymap.set("n", "<leader>/", "<cmd>Tico grep<cr>")
