local lualine = require("lualine")

local colors = require("colors").get()

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 150
  end,
}

-- Specific buffer
local tree_buffer = {
  sections = {
    lualine_a = {
      {
        function()
          return "NVIMTREE"
        end,
        color = { fg = colors.blue, bg = colors.bg_dark, gui = "bold" }
      }
    }
  },
  inactive_sections = {
    lualine_a = {
      {
        function()
          return "NVIMTREE"
        end,
        color = { fg = colors.fg_darker, gui = "bold" }
      }
    }
  },
  filetypes = { "NvimTree" }
}

-- Config
local config = {
  options = {
    component_separators = "",
    section_separators = "",
    theme = {
      normal = {
        a = { fg = colors.bg_dark, bg = colors.blue },
        b = { fg = colors.fg, bg = colors.bg_dark },
        c = { fg = colors.fg, bg = colors.bg_dark },
      },
      inactive = {
        a = { fg = colors.fg_darker, bg = colors.bg_dark },
        x = { fg = colors.fg_darker, bg = colors.bg_dark },
      },
      insert = { a = { fg = colors.bg_dark, bg = colors.green } },
      visual = { a = { fg = colors.bg_dark, bg = colors.orange } },
      replace = { a = { fg = colors.bg_dark, bg = colors.red } },
      command = { a = { fg = colors.bg_dark, bg = colors.purple } },
    },
  },
  sections = {
    lualine_a = {
      -- VIM mode
      {
        "mode",
        icon = "",
        color = { gui = "bold" }
      },
    },
    lualine_b = {
      -- Git branch
      {
        "branch",
        icon = " ",
        cond = conditions.hide_in_width,
        color = { fg = colors.magenta, bg = colors.bg_light },
      },
      -- File name
      {
        "filename",
        path = 1,
        shorting_target = 90,
        cond = conditions.buffer_not_empty,
      },
      -- Git diff
      {
        "diff",
        symbols = { added = " ", modified = " ", removed = " " },
        diff_color = {
          added = { fg = colors.green },
          modified = { fg = colors.yellow },
          removed = { fg = colors.red },
        },
        cond = conditions.hide_in_width,
      }
    },
    lualine_x = {
      -- Lsp Diagnostics
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = { error = " ", warn = " ", info = " " },
        diagnostics_color = {
          color_error = { fg = colors.red },
          color_warn = { fg = colors.yellow },
          color_info = { fg = colors.green },
        },
      },
      -- LSP server name
      {
        function()
          local msg = "No Active Lsp"
          local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
          local clients = vim.lsp.get_active_clients()
          if next(clients) == nil then
            return msg
          end
          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
              return client.name
            end
          end
          return msg
        end,
        icon = " ",
        color = { fg = colors.fg },
      },
      {
        "fileformat",
        fmt = string.upper,
        icons_enabled = false,
        color = { fg = colors.fg },
      },
      {
        "location",
      },
      {
        "progress",
        color = { bg = colors.bg_lighter },
      },
    },
    lualine_c = {},
    lualine_y = {},
    lualine_z = {},
  },
  inactive_sections = {
    lualine_a = {
      {
        "filename",
        path = 1,
        shorting_target = 120,
        cond = conditions.buffer_not_empty,
      },
    },
    lualine_x = {
      "location",
      "progress",
    },
    lualine_b = {},
    lualine_c = {},
    lualine_y = {},
    lualine_z = {},
  },
  extensions = { tree_buffer },
}

lualine.setup(config)
