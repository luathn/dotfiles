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
    event = "VeryLazy",
    config = function()
      require("core.utils").load_mappings("vim_fugitive")
    end,
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
    event = "VeryLazy",
    config = function()
      require("core.utils").load_mappings("ctrlsf")
      require("plugins.ctrlsf")
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", opts = {} },
      { "williamboman/mason-lspconfig.nvim", opts = {} },
      -- Useful status updates for LSP
      { "j-hui/fidget.nvim", opts = {} },
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
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("core.utils").load_mappings("nvim_telescope")
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
      "sindrets/diffview.nvim",
      event = "VeryLazy",
      config = function()
        require("core.utils").load_mappings("diffview")
        require("plugins.diffview")
      end,
    },
    event = "VeryLazy",
    config = function()
      require("core.utils").load_mappings("neogit")
      require("plugins.neogit")
    end,
  },
  {
    "ojroques/nvim-bufdel",
    event = "VeryLazy",
    commit = "9f1ed6e",
    config = function()
      require("core.utils").load_mappings("nvim_bufdel")
      require("plugins.nvim_bufdel")
    end,
  },
  {
    "vim-test/vim-test",
    config = function()
      require("core.utils").load_mappings("vim_test")
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
    event = "VeryLazy",
    config = function()
      require("core.utils").load_mappings("nvim_spectre")
      require("plugins.nvim-spectre")
    end,
  },
  -- Test
  {
    'Wansmer/treesj',
    requires = { 'nvim-treesitter' },
    config = function()
      require("core.utils").load_mappings("treesj")
      require("plugins.treesj")
    end,
  },
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
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {},
  },
  -- {
  --   "stevearc/oil.nvim",
  --   config = function()
  --     require("core.utils").load_mappings("oil")
  --     require("plugins.oil")
  --   end,
  -- },
  -- {
  --   "akinsho/nvim-bufferline.lua",
  --   config = function()
  --     require("core.utils").load_mappings("nvim_bufferline")
  --     require("plugins.nvim-bufferline")
  --   end,
  -- },
  -- {
  --   "kyazdani42/nvim-tree.lua",
  --   dependencies = { "nvim-tree/nvim-web-devicons" },
  --   event = "VeryLazy",
  --   config = function()
  --     require("core.utils").load_mappings("nvim_tree")
  --     require("plugins.nvim-tree")
  --   end,
  -- },
  -- {
  --   "folke/tokyonight.nvim",
  --   priority = 1000,
  --   config = function()
  --     vim.cmd.colorscheme "tokyonight-day"
  --   end,
  -- },
}
