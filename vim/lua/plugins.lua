return {
  {
    "nvim-tree/nvim-web-devicons",
  },
  {
    "nvim-lua/plenary.nvim",
  },
  -- Main plugins
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        event = "VeryLazy",
      },
      {
        'JoosepAlviste/nvim-ts-context-commentstring',
        event = "VeryLazy",
      }
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
    config = function()
      require('Comment').setup {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    opts = {}
  },
  {
    "numToStr/Navigator.nvim",
    keys = require("mappings").navigator,
    config = function()
      require('Navigator').setup()
    end
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", opts = {} },
      { "williamboman/mason-lspconfig.nvim", opts = {} },
      { "j-hui/fidget.nvim", tag = "legacy", opts = {} },
    },
    config = function()
      require("plugins.nvim-lspconfig")
    end,
  },
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
    keys = require("mappings").nvim_telescope,
    event = "VeryLazy",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        event = "VeryLazy",
        build = "make",
        cond = function()
          return vim.fn.executable "make" == 1
        end,
      },
    },
    config = function()
      require("plugins.nvim-telescope")
    end,
  },
  {
    "TimUntersberger/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "sindrets/diffview.nvim",
        keys = require("mappings").diffview,
        event = "VeryLazy",
        config = function()
          require("plugins.diffview")
        end,
      },
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
  {
    "catppuccin/nvim",
    priority = 1000,
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        flavour = "latte",
        no_bold = true,
      })
      vim.cmd.colorscheme "catppuccin"
    end,
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
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("plugins.nvim-ts-autotag")
    end
  },
  {
    "mfussenegger/nvim-dap",
    -- dependencies = "rcarriga/nvim-dap-ui",
    keys = require("mappings").nvim_dap,
    config = function()
      require("plugins.nvim-dap")
    end,
  },
  {
    "luckasRanarison/nvim-devdocs",
    keys = require("mappings").devdocs,
    event = "VeryLazy",
    config = function()
      require("plugins.nvim-devdocs")

      vim.keymap.set("n", "<leader>dd", "<cmd>lua require('plugins.fzf-lua-devdocs').open_picker()<CR>")
    end,
  },
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = require("mappings").fzf_lua,
    config = function()
      require("plugins.fzf-lua")
    end
  },
  -- Test
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      require("toggleterm").setup({
        -- size can be a number or function which is passed the current terminal
        size = 20,
        open_mapping = [[<c-/>]],
        shade_filetypes = {},
        autochdir = false, -- when neovim changes it current directory the terminal will change it's own when next it's opened
        -- shading_factor = '<number>', -- the percentage by which to lighten terminal background, default: -30 (gets multiplied by -3 if background is light)
        start_in_insert = false,
        insert_mappings = true, -- whether or not the open mapping applies in insert mode
        terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
        persist_size = true,
        persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
        direction = 'tab',
        close_on_exit = true, -- close the terminal window when the process exits
        -- Change the default shell. Can be a string or a function returning a string
        shell = vim.o.shell,
        auto_scroll = true, -- automatically scroll to the bottom on terminal output
        -- This field is only relevant if direction is set to 'float'
        float_opts = {
          -- The border key is *almost* the same as 'nvim_open_win'
          -- see :h nvim_open_win for details on borders however
          -- the 'curved' border is a custom border type
          -- not natively supported but implemented in this plugin.
          border = "single",
          -- like `size`, width and height can be a number or function which is passed the current terminal
          winblend = 3,
          -- zindex = <value>,
        },
        winbar = {
          enabled = false,
          name_formatter = function(term) --  term: Terminal
            return term.name
          end
        },
      })
    end
  },
  -- {
  --   "christoomey/vim-tmux-navigator",
  --   event = "VeryLazy",
  -- },
  -- {
  --   "junegunn/fzf.vim",
  --   keys = require("mappings").fzf,
  --   config = function()
  --     require("plugins.fzf")
  --   end,
  -- },
}
