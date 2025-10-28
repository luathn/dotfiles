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

      local disabled_filetypes = { terminal = true, snacks_terminal = true }
      local disable_in_ft = function(opts)
        local ft = vim.bo[opts.buf].filetype
        if disabled_filetypes[ft] then vim.b[opts.buf].miniindentscope_disable = true end
      end
      local augroup = vim.api.nvim_create_augroup('MiniIndentScopeDisable', { clear = true })
      vim.api.nvim_create_autocmd('FileType', { group = augroup, callback = disable_in_ft })
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
    "simifalaye/minibuffer.nvim",
    init = function()
      if vim.fn.has("nvim-0.12") == 1 then
        local minibuffer = require("minibuffer")

        vim.ui.select = require("minibuffer.builtin.ui_select")
        vim.ui.input = require("minibuffer.builtin.ui_input")

        vim.keymap.set("n", "<M-;>", require("minibuffer.builtin.cmdline"))
        vim.keymap.set("n", "<M-.>", function()
          minibuffer.resume(true)
        end)
        vim.keymap.set("n", "<leader>.", require("minibuffer.examples.files"))
        vim.keymap.set("n", "<leader>,", require("minibuffer.examples.buffers"))
        vim.keymap.set("n", "<leader>/", require("minibuffer.examples.live-grep"))
        vim.keymap.set("n", "<leader>o", function()
          require("minibuffer.examples.oldfiles")({ cwd = vim.fn.getcwd() })
        end)
        vim.keymap.set("n", "<leader>O", require("minibuffer.examples.oldfiles"))
      end
    end,
  },
  {
     "maskudo/devdocs.nvim",
    lazy = false,
    dependencies = {
      "folke/snacks.nvim",
    },
    cmd = { "DevDocs" },
    keys = {
      { "<leader>ho", mode = "n", "<cmd>DevDocs get<cr>", desc = "Get Devdocs" },
      { "<leader>hi", mode = "n", "<cmd>DevDocs install<cr>", desc = "Install Devdocs" },
      {
        "<leader>hv",
        mode = "n",
        function()
          local devdocs = require("devdocs")
          local installedDocs = devdocs.GetInstalledDocs()
          vim.ui.select(installedDocs, {}, function(selected)
            if not selected then
              return
            end
            local docDir = devdocs.GetDocDir(selected)
            -- prettify the filename as you wish
            Snacks.picker.files({ cwd = docDir })
          end)
        end,
        desc = "Get Devdocs",
      },
      { "<leader>hd", mode = "n", "<cmd>DevDocs delete<cr>", desc = "Delete Devdoc" }
    },
    opts = {
      ensure_installed = {
        "go",
      },
    },
  },
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
  --   "mfussenegger/nvim-dap",
  --   -- dependencies = "rcarriga/nvim-dap-ui",
  --   keys = require("mappings").nvim_dap,
  --   config = function()
  --     require("plugins.nvim-dap")
  --   end,
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
