local mappings = require("mappings")

return {
  { "nvim-lua/plenary.nvim" },
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    dependencies = {
      { "Wansmer/treesj", keys = mappings.treesj, config = function() require("plugins.treesj") end },
      -- {"nvim-treesitter/nvim-treesitter-textobjects"},
      -- {"folke/ts-comments.nvim", opts = {}},
      -- {"windwp/nvim-ts-autotag", opts = {}},
    },
    config = function()
      require("plugins.treesitter")
    end,
  },
  -- LSP
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      { "williamboman/mason.nvim",                  opts = {} },
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
      require("plugins.mini_indentscope")
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
      require("plugins.conform")
    end
  },
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    opts = require("plugins.claudecode"),
    keys = mappings.claudecode,
    init = function()
      vim.keymap.set("n", "<leader>a1", function()
        vim.cmd("ClaudeCodeFocus")
        vim.api.nvim_feedkeys("1", "n", false)
        vim.schedule(function()
          vim.cmd("wincmd p")
        end)
      end)

      vim.keymap.set("n", "<leader>a3", function()
        vim.cmd("ClaudeCodeFocus")
        vim.api.nvim_feedkeys("3", "n", false)
        vim.schedule(function()
          vim.cmd("wincmd p")
        end)
      end)
    end
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        'leoluz/nvim-dap-go',
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
      },
    },
    lazy = true,
    keys = mappings.dap,
    config = function() require("plugins.dap") end,
  },
  -- {
  --   "maskudo/devdocs.nvim",
  --   lazy = false,
  --   dependencies = {
  --     "folke/snacks.nvim",
  --   },
  --   cmd = { "DevDocs" },
  --   keys = {
  --     { "<leader>ho", mode = "n", "<cmd>DevDocs get<cr>",     desc = "Get Devdocs" },
  --     { "<leader>hi", mode = "n", "<cmd>DevDocs install<cr>", desc = "Install Devdocs" },
  --     {
  --       "<leader>hv",
  --       mode = "n",
  --       function()
  --         local devdocs = require("devdocs")
  --         local installedDocs = devdocs.GetInstalledDocs()
  --         vim.ui.select(installedDocs, {}, function(selected)
  --           if not selected then
  --             return
  --           end
  --           local docDir = devdocs.GetDocDir(selected)
  --           -- prettify the filename as you wish
  --           Snacks.picker.files({ cwd = docDir })
  --         end)
  --       end,
  --       desc = "Get Devdocs",
  --     },
  --     { "<leader>hd", mode = "n", "<cmd>DevDocs delete<cr>", desc = "Delete Devdoc" }
  --   },
  --   opts = {
  --     ensure_installed = {
  --       "go",
  --     },
  --   },
  -- },
}
