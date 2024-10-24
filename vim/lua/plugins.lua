local mappings = require("mappings")

return {
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
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "VeryLazy",
  },
  -- LSP
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      { "williamboman/mason.nvim", opts = {} },
      { "williamboman/mason-lspconfig.nvim", opts = {} },
    },
    config = function()
      require("plugins.nvim-lspconfig")
    end,
  },
  -- Main plugins
  {
    "tpope/vim-fugitive",
    keys = mappings.vim_fugitive,
    event = "VeryLazy",
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },
  {
    "numToStr/Navigator.nvim",
    keys = mappings.navigator,
    config = function() require('Navigator').setup() end,
  },
  {
    "windwp/nvim-autopairs",
    event = "VeryLazy",
    opts = {},
  },
  {
    "hrsh7th/nvim-cmp",
    event = "VeryLazy",
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
    "TimUntersberger/neogit",
    keys = mappings.neogit,
    event = "VeryLazy",
    config = function()
      require("plugins.neogit")
    end,
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
    "ojroques/nvim-bufdel",
    keys = mappings.nvim_bufdel,
    event = "VeryLazy",
    commit = "9f1ed6e",
    config = function()
      require("plugins.nvim_bufdel")
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
        flavour = "latte",
        no_bold = true,
      })
      vim.cmd.colorscheme "catppuccin-latte"
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("plugins.lualine")
    end,
  },
  {
    "stevearc/oil.nvim",
    keys = mappings.oil,
    event = "VeryLazy",
    config = function()
      require("plugins.oil")
    end,
  },
  {
    "ibhagwan/fzf-lua",
    event = "VeryLazy",
    keys = mappings.fzf_lua,
    config = function()
      require("plugins.fzf-lua")
    end
  },
  {
    'MagicDuck/grug-far.nvim',
    event = "VeryLazy",
    keys = mappings.grug_far,
    config = function()
      require("plugins.grug_far")
    end
  },
  { "tpope/vim-rails", config = function() end },
  -- Test
  {
    'akinsho/toggleterm.nvim',
    event = "VeryLazy",
    version = "*",
    config = function()
      require("plugins.toggleterm")
    end
  },
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
    "robitx/gp.nvim",
    event = "VeryLazy",
    config = function()
      require("plugins.gp")
    end
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false,
    opts = require("plugins.avante"),
    build = "make",
    dependencies = {
      "stevearc/dressing.nvim",
      "MunifTanjim/nui.nvim",
      { "zbirenbaum/copilot.lua", opts = {} },
      {
        'MeanderingProgrammer/render-markdown.nvim',
        event = "VeryLazy",
        opts = { file_types = { "Avante" } },
        ft = { "Avante" },
      },
    },
    -- init = function()
    --   vim.api.nvim_create_autocmd("VimEnter", {
    --     callback = function()
    --       -- Ensure Avante.nvim has been loaded before switching providers
    --       if vim.fn.exists(":AvanteSwitchProvider") == 2 then
    --         vim.cmd("AvanteSwitchProvider copilot")
    --       end
    --     end,
    --   })
    -- end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    event = "VeryLazy",
    branch = "canary",
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
    'echasnovski/mini.ai',
    event = "VeryLazy",
    version = false,
    opts = {},
  },
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
}
