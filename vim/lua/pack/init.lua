local load_keys = require("core.utils").load_keys
local mappings = require("mappings")

-- Util
vim.pack.add({ "https://github.com/nvim-lua/plenary.nvim" })

-- UI
vim.pack.add({ "https://github.com/catppuccin/nvim" })
require("catppuccin").setup({})
vim.cmd.colorscheme("catppuccin-frappe")

-- Editor
vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })
vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter-context" })
vim.pack.add({ "https://github.com/Wansmer/treesj" })
require("pack.treesitter")
load_keys(mappings.treesj)

vim.pack.add({ "https://github.com/echasnovski/mini.surround" })
require("pack.mini_surround")

vim.cmd("packadd nvim.undotree") -- Saved at ~/.local/state/nvim/undo
load_keys(mappings.undotree)

vim.pack.add({ "https://github.com/saghen/blink.cmp" })
require("pack.blink_cmp")

vim.pack.add({ "https://github.com/mason-org/mason.nvim" })
vim.pack.add({ "https://github.com/mason-org/mason-lspconfig.nvim" })
vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })
require("pack.lsp")

-- Git
vim.cmd("packadd nvim.difftool")

vim.pack.add({ "https://github.com/sindrets/diffview.nvim" })
load_keys(mappings.diffview)
require("pack.diffview")

vim.pack.add({ "https://github.com/neogitorg/neogit" })
load_keys(mappings.neogit)
require("pack.neogit")

vim.pack.add({ "https://github.com/nvim-mini/mini-git" })
load_keys(mappings.mini_git)
require("pack.mini_git")

-- Navigation
vim.pack.add({ "https://github.com/stevearc/oil.nvim" })
load_keys(mappings.oil)
require("pack.oil")

vim.pack.add({ "https://github.com/MagicDuck/grug-far.nvim" })
load_keys(mappings.grug_far)
require("pack.grug_far")

-- Tools
vim.pack.add({ "https://github.com/vim-test/vim-test" })
load_keys(mappings.vim_test)
require("pack.vim_test")

-- Debug
vim.pack.add({ "https://github.com/mfussenegger/nvim-dap" })
vim.pack.add({ "https://github.com/igorlfs/nvim-dap-view" })
vim.pack.add({ "https://github.com/leoluz/nvim-dap-go" })
load_keys(mappings.dap)
require("pack.dap")

-- AI
vim.pack.add({ "https://github.com/coder/claudecode.nvim" })
load_keys(mappings.claudecode)
require("pack.claudecode")

-- Test
vim.opt.rtp:prepend(vim.fn.expand("~/code/nvimtico"))
vim.g.nvimtico_ui_select = true
vim.keymap.set("n", "<leader><space>", "<cmd>Tico files<cr>")
vim.keymap.set("n", "<leader>,", "<cmd>Tico buffers<cr>")
vim.keymap.set("n", "<leader>/", "<cmd>Tico grep<cr>")
