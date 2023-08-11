return {
  -- Main plugins
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      event = "VeryLazy",
    },
    config = function()
      require("plugins.treesitter")
    end,
  },
  {
    "tpope/vim-fugitive",
    keys = require("mappings").vim_fugitive,
    event = "VeryLazy",
  },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    opts = {}
  },
  {
    "christoomey/vim-tmux-navigator",
    event = "VeryLazy",
  },
  {
    "dyng/ctrlsf.vim",
    keys = require("mappings").ctrlsf,
    event = "VeryLazy",
    config = function()
      require("plugins.ctrlsf")
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", opts = {} },
      { "williamboman/mason-lspconfig.nvim", opts = {} },
      -- Useful status updates for LSP
      { "j-hui/fidget.nvim", tag = "legacy", opts = {} },
    },
    config = function()
      require("plugins.nvim-lspconfig")
    end,
  },
  -- { "metakirby5/codi.vim", lazy = true },
  {
    "windwp/nvim-autopairs",
    event = "VeryLazy",
    opts = {}
  },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      require("plugins.nvim-cmp")
    end,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
  },
  {
    "nvim-lua/plenary.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = require("mappings").nvim_telescope,
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("plugins.nvim-telescope")
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    event = "VeryLazy",
    build = "make",
    cond = function()
      return vim.fn.executable "make" == 1
    end,
  },
  {
    "TimUntersberger/neogit",
    dependencies = {
      {
        "sindrets/diffview.nvim",
        keys = require("mappings").diffview,
        event = "VeryLazy",
        config = function()
          require("plugins.diffview")
        end,
      },
      { "nvim-lua/plenary.nvim" }
    },
    keys = require("mappings").neogit,
    event = "VeryLazy",
    config = function()
      require("plugins.neogit")
    end,
  },
  {
    "ojroques/nvim-bufdel",
    keys = require("mappings").nvim_bufdel,
    event = "VeryLazy",
    commit = "9f1ed6e",
    config = function()
      require("plugins.nvim_bufdel")
    end,
  },
  {
    "vim-test/vim-test",
    keys = require("mappings").vim_test,
    config = function()
      require("plugins.vim_test")
    end,
    event = "VeryLazy",
  },
  {
    "ggandor/leap.nvim",
    event = "VeryLazy",
    config = function()
      require("leap").add_default_mappings()
    end,
  },
  -- UI
  {
    "catppuccin/nvim",
    priority = 1000,
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        flavour = "latte", -- latte, frappe, macchiato, mocha
        no_bold = true, -- Force no bold
      })
      vim.cmd.colorscheme "catppuccin"
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("plugins.lualine")
    end,
  },
  {
    "nvim-pack/nvim-spectre",
    keys = require("mappings").nvim_spectre,
    event = "VeryLazy",
    config = function()
      require("plugins.nvim-spectre")
    end,
  },
  {
    'Wansmer/treesj',
    keys = require("mappings").treesj,
    requires = { 'nvim-treesitter' },
    config = function()
      require("plugins.treesj")
    end,
  },
  -- Test
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 500
    end,
    opts = {},
  },
  {
    'kevinhwang91/nvim-bqf',
    dependencies = {
      'junegunn/fzf',
    }
  },
  {
    "junegunn/fzf.vim",
    keys = require("mappings").fzf,
    config = function()
      require("plugins.fzf")
    end,
  },
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {},
  },
  {
    "stevearc/oil.nvim",
    keys = require("mappings").oil,
    config = function()
      require("plugins.oil")
    end,
  },
  { "jlanzarotta/bufexplorer" },
  {
    "ThePrimeagen/harpoon",
    keys = require("mappings").harpoon,
    config = function()
      require("harpoon").setup({
        menu = {
          width = 120,
        }
      })
    end,
  },
  -- {
  --   "akinsho/nvim-bufferline.lua",
  --   config = function()
  --     require("plugins.nvim-bufferline")
  --   end,
  --   keys = require("mappings").nvim_bufferline,
  -- },
  -- {
  --   "kyazdani42/nvim-tree.lua",
  --   dependencies = { "nvim-tree/nvim-web-devicons" },
  --   event = "VeryLazy",
  --   config = function()
  --     require("plugins.nvim-tree")
  --   end,
  --   keys = require("mappings").nvim_tree,
  -- },
  -- {
  --   "folke/tokyonight.nvim",
  --   priority = 1000,
  --   config = function()
  --     vim.cmd.colorscheme "tokyonight-day"
  --   end,
  -- },
}
