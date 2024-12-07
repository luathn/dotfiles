local mappings = require("mappings")

return {
  { "dstein64/vim-startuptime" },
  { "nvim-tree/nvim-web-devicons" },
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
    'Wansmer/treesj',
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
    config = function()
      require("plugins.nvim-ts-autotag")
    end,
  },
  -- LSP
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      { "williamboman/mason.nvim", opts = {} },
      { "williamboman/mason-lspconfig.nvim", opts = {} },
      { 'saghen/blink.cmp' },
    },
    config = function()
      require("plugins.nvim-lspconfig")
    end,
  },
  -- Base plugins
  {
    "numToStr/Navigator.nvim",
    keys = mappings.navigator,
    config = function() require('Navigator').setup() end,
  },
  -- Mini
  {
    'echasnovski/mini.pick',
    version = false,
    event = "VeryLazy",
    config = function()
      require("plugins.mini_pick")
    end,
    keys = mappings.mini_pick,
  },
  {
    'echasnovski/mini.extra',
    event = "VeryLazy",
    version = false,
    config = function()
      require('mini.extra').setup()
    end
  },
  {
    "echasnovski/mini.surround",
    event = "VeryLazy",
    version = false,
    config = function()
      require('plugins.mini_surround')
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },
  {
    'echasnovski/mini.pairs',
    event = "VeryLazy",
    version = false,
    config = function()
      require('mini.pairs').setup()
    end
  },
  {
    'echasnovski/mini.statusline',
    version = false,
    config = function()
      require('plugins.mini_statusline')
    end
  },
  {
    'echasnovski/mini-git',
    event = "VeryLazy",
    version = false,
    main = 'mini.git',
    config = function()
      require('plugins.mini_git')
    end,
    keys = mappings.mini_git,
  },
  {
    'echasnovski/mini.bufremove',
    event = "VeryLazy",
    version = false,
    keys = mappings.mini_bufremove,
    config = function()
      require('plugins.mini_bufremove')
    end,
  },
  {
    'saghen/blink.cmp',
    event = 'VeryLazy',
    dependencies = 'rafamadriz/friendly-snippets',
    version = 'v0.*',
    opts = require('plugins.blink_cmp'),
    opts_extend = { "sources.completion.enabled_providers" }
  },
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
      "echasnovski/mini.pick",
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
        flavour = "frappe",
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
    'MagicDuck/grug-far.nvim',
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
  -- Test
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettier,
        },
      })
    end,
  },
  {
    'akinsho/git-conflict.nvim',
    version = "*",
    event = "VeryLazy",
    config = true,
  },
  {
    "robitx/gp.nvim",
    event = "VeryLazy",
    config = function()
      require("plugins.gp")
    end
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    event = "VeryLazy",
    branch = "main",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      debug = true, -- Enable debugging
      -- See Configuration section for rest
    },
    keys = mappings.copilot_chat,
  },
  {
    "olimorris/codecompanion.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- The following are optional:
      { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } },
    },
    config = true,
    opts = require('plugins.codecompanion')
  },
  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   event = "InsertEnter",
  --   opts = require("plugins.copilot_config")
  -- },
  -- {
  --   "yetone/avante.nvim",
  --   event = "VeryLazy",
  --   version = false,
  --   build = "make",
  --   dependencies = {
  --     { "stevearc/dressing.nvim" },
  --     { "MunifTanjim/nui.nvim" },
  --     { "zbirenbaum/copilot.lua", opts = {} },
  --     { 'MeanderingProgrammer/render-markdown.nvim', opts = { file_types = { "Avante" } }, ft = { "Avante" } },
  --   },
  -- },

  -- Replaced by mini
  -- {
  --   "ibhagwan/fzf-lua",
  --   event = "VeryLazy",
  --   keys = mappings.fzf_lua,
  --   config = function()
  --     require("plugins.fzf-lua")
  --   end
  -- },
  -- {
  --   "kylechui/nvim-surround",
  --   version = "*",
  --   -- event = "VeryLazy",
  --   opts = {},
  -- },
  -- {
  --   "windwp/nvim-autopairs",
  --   event = "VeryLazy",
  --   opts = {},
  -- },
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   config = function()
  --     require("plugins.lualine")
  --   end,
  -- },
  -- {
  --   "ojroques/nvim-bufdel",
  --   keys = mappings.nvim_bufdel,
  --   event = "VeryLazy",
  --   commit = "9f1ed6e",
  --   config = function()
  --     require("plugins.nvim_bufdel")
  --   end,
  -- },
  -- {
  --   "tpope/vim-fugitive",
  --   keys = mappings.vim_fugitive,
  --   event = "VeryLazy",
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
  --   'kevinhwang91/nvim-bqf',
  --   dependencies = { 'junegunn/fzf' },
  -- },
  -- {
  --   "nvim-pack/nvim-spectre",
  --   keys = require("mappings").nvim_spectre,
  --   event = "VeryLazy",
  --   config = function()
  --     require("plugins.nvim-spectre")
  --   end,
  -- },
  -- {
  --   "luckasRanarison/nvim-devdocs",
  --   keys = require("mappings").devdocs,
  --   event = "VeryLazy",
  --   config = function()
  --     require("plugins.nvim-devdocs")
  --
  --     vim.keymap.set("n", "<leader>dd", "<cmd>lua require('plugins.fzf-lua-devdocs').open_picker()<CR>")
  --   end,
  -- },
  -- {
  --   "nvim-telescope/telescope.nvim",
  --   keys = require("mappings").nvim_telescope,
  --   event = "VeryLazy",
  --   dependencies = {
  --     {
  --       "nvim-telescope/telescope-fzf-native.nvim",
  --       event = "VeryLazy",
  --       build = "make",
  --       cond = function()
  --         return vim.fn.executable "make" == 1
  --       end,
  --     },
  --   },
  --   config = function()
  --     require("plugins.nvim-telescope")
  --   end,
  -- },
  -- { "jlanzarotta/bufexplorer" },
  -- {
  --   'akinsho/toggleterm.nvim',
  --   event = "VeryLazy",
  --   version = "*",
  --   config = function()
  --     require("plugins.toggleterm")
  --   end
  -- },
}
