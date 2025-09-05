local mappings = require("mappings")

return {
  -- { "dstein64/vim-startuptime" },
  { "nvim-lua/plenary.nvim" },
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    config = function()
      require("plugins.treesitter")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "VeryLazy",
  },
  {
    "Wansmer/treesj",
    keys = mappings.treesj,
    event = "VeryLazy",
    config = function() require("plugins.treesj") end,
  },
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "VeryLazy",
    opts = {},
  },
  -- LSP
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = {},
      },
      { "williamboman/mason-lspconfig.nvim" },
      { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
      { "saghen/blink.cmp" },
    },
    config = function()
      require("plugins.nvim-lspconfig")
    end,
  },
  -- Mini
  {
    "echasnovski/mini.surround",
    event = "VeryLazy",
    version = false,
    config = function()
      require("plugins.mini_surround")
    end,
  },
  {
    "echasnovski/mini.statusline",
    version = false,
    config = function()
      require("plugins.mini_statusline")
    end
  },
  {
    "echasnovski/mini.indentscope",
    event = "VeryLazy",
    version = false,
    config = function()
      require("mini.indentscope").setup({
        draw = {
          delay = 0,
          animation = require("mini.indentscope").gen_animation.none(),
        },
      })
    end
  },
  {
    "echasnovski/mini.cursorword",
    version = false,
    config = function()
      require("mini.cursorword").setup({
        delay = 500
      })
    end
  },
  {
    "echasnovski/mini.icons",
    version = false,
    config = function()
      require("mini.icons").setup()
    end
  },
  -- {
  --   'echasnovski/mini.pick',
  --   version = false,
  --   keys = mappings.mini_pick,
  --   config = function()
  --     require("plugins.mini_pick")
  --   end
  -- },
  -- Base plugins
  {
    "tpope/vim-fugitive",
    keys = mappings.vim_fugitive,
    event = "VeryLazy",
  },
  {
    "saghen/blink.cmp",
    dependencies = "rafamadriz/friendly-snippets",
    version = "*",
    opts = require("plugins.blink_cmp"),
    opts_extend = { "sources.default" }
  },
  {
    "TimUntersberger/neogit",
    keys = mappings.neogit,
    event = "VeryLazy",
    config = function()
      require("plugins.neogit")
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
  },
  {
    "sindrets/diffview.nvim",
    keys = mappings.diffview,
    event = "VeryLazy",
    config = function()
      require("plugins.diffview")
    end,
  },
  {
    "vim-test/vim-test",
    keys = mappings.vim_test,
    config = function()
      require("plugins.vim_test")
    end,
    event = "VeryLazy",
  },
  {
    "catppuccin/nvim",
    priority = 1000,
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        no_bold = true,
      })
      vim.cmd.colorscheme "catppuccin-frappe"
    end,
  },
  {
    "stevearc/oil.nvim",
    event = "VeryLazy",
    keys = mappings.oil,
    config = function()
      require("plugins.oil")
    end,
  },
  {
    "MagicDuck/grug-far.nvim",
    event = "VeryLazy",
    keys = mappings.grug_far,
    config = function()
      require("plugins.grug_far")
    end
  },
  {
    "tpope/vim-rails",
    event = "VeryLazy",
    config = function() end,
  },
  {
    "robitx/gp.nvim",
    event = "VeryLazy",
    config = function()
      require("plugins.gp")
    end
  },
  -- Test
  {
    "folke/snacks.nvim",
    lazy = false,
    keys = mappings.snacks,
    init = function()
      require("plugins.snacks")
    end
  },
  {
    "stevearc/conform.nvim",
    opts = {},
    init = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          ruby = { "rubocop" },
          markdown = { "prettier" },
          -- javascript = { "prettierd", "prettier", stop_after_first = true },
        },
        -- format_on_save = {
        --   -- These options will be passed to conform.format()
        --   timeout_ms = 1500,
        --   lsp_format = "fallback",
        -- },
      })

      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end
  },
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    keys = {
      { "<leader>a",  nil,                              desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>",            desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>",       desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>",   desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",       desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>",        mode = "v",                  desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Deny diff" },
    },
  }
  -- {
  --   "hrsh7th/nvim-cmp",
  --   event = "VeryLazy",
  --   config = function()
  --     require("plugins.nvim-cmp")
  --   end,
  --   dependencies = {
  --     "hrsh7th/cmp-nvim-lsp",
  --     "hrsh7th/cmp-buffer",
  --     "hrsh7th/cmp-path",
  --     "hrsh7th/cmp-cmdline",
  --     -- "L3MON4D3/LuaSnip",
  --     -- "saadparwaiz1/cmp_luasnip",
  --     -- "rafamadriz/friendly-snippets",
  --   },
  -- },
  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   event = "InsertEnter",
  --   opts = require("plugins.copilot_config")
  -- },
  -- {
  --   "echasnovski/mini-git",
  --   event = "VeryLazy",
  --   version = false,
  --   main = "mini.git",
  --   config = function()
  --     require("plugins.mini_git")
  --   end,
  --   keys = mappings.mini_git,
  -- },
  -- Replaced by mini
  -- {
  --   "kylechui/nvim-surround",
  --   version = "*",
  --   event = "VeryLazy",
  --   opts = {},
  -- },
  -- {
  --   "ibhagwan/fzf-lua",
  --   event = "VeryLazy",
  --   -- keys = mappings.fzf_lua,
  --   config = function()
  --     require("plugins.fzf-lua")
  --   end
  -- },
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   config = function()
  --     require("plugins.lualine")
  --   end,
  -- },
  -- {
  --   "mfussenegger/nvim-dap",
  --   -- dependencies = "rcarriga/nvim-dap-ui",
  --   keys = require("mappings").nvim_dap,
  --   config = function()
  --     require("plugins.nvim-dap")
  --   end,
  -- },
  -- {
  --   "kevinhwang91/nvim-bqf",
  --   dependencies = { "junegunn/fzf" },
  -- },
  -- {
  --   "luckasRanarison/nvim-devdocs",
  --   keys = require("mappings").devdocs,
  --   event = "VeryLazy",
  --   config = function()
  --     require("plugins.nvim-devdocs")
  --
  --     vim.keymap.set("n", "<leader>dd", "<cmd>lua require("plugins.fzf-lua-devdocs").open_picker()<CR>")
  --   end,
  -- },
  -- {
  --   "numToStr/Navigator.nvim",
  --   keys = mappings.navigator,
  --   config = function() require("Navigator").setup() end,
  -- },
}
