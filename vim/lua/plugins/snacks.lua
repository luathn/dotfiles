local bg = require("core.utils").bg
local fg = require("core.utils").fg
local colors = require("catppuccin.palettes").get_palette "frappe"

bg("SnacksPicker", colors.mantle)
bg("SnacksPickerBorder", colors.mantle)
fg("SnacksPickerBorder", colors.mantle)

fg("SnacksPickerDir", colors.text)

require("snacks").setup({
  picker = {
    prompt = "󰘍 ",
    main = {
      current = true,
    },
    hidden = true,
    actions = {
      switch_to_buffers = function(picker, _)
        local pattern = picker.input.filter.pattern
        picker:close()
        Snacks.picker.buffers({ pattern = pattern })
      end,
      switch_to_files = function(picker, _)
        local pattern = picker.input.filter.pattern
        picker:close()
        Snacks.picker.files({ pattern = pattern })
      end,
      switch_to_smart = function(picker, _)
        local pattern = picker.input.filter.pattern
        picker:close()
        Snacks.picker.smart({ pattern = pattern })
      end,
      open_explorer = function(picker, item)
        picker:close()
        local dir = picker:dir()
        require('oil').open(dir)
        -- vim.schedule(function()
        --   require('oil').open(dir_path)
        -- end)
      end,
    },
    sources = {
      files = {
        layout = {
          preview = false,
        },
        win = {
          input = {
            keys = {
              ["<c-;>"] = { "switch_to_buffers", mode = { "n", "i" } },
              ["<c-e>"] = { "open_explorer", mode = { "n", "i" } },
            },
          },
        }
      },
      smart = {
        -- prompt = "Files> ",
        layout = {
          preview = false,
        },
        win = {
          input = {
            keys = {
              ["<c-;>"] = { "switch_to_buffers", mode = { "n", "i" } },
              ["<c-e>"] = { "open_explorer", mode = { "n", "i" } },
            },
          },
        }
      },
      buffers = {
        finder = "buffers",
        format = "buffer",
        current = false,
        sort_lastused = true,
        layout = {
          preview = "main",
        },
        win = {
          input = {
            keys = {
              ["<c-x>"] = { "bufdelete", mode = { "n", "i" } },
              ["<c-;>"] = { "switch_to_smart", mode = { "n", "i" } },
              ["<c-e>"] = { "open_explorer", mode = { "n", "i" } },
            },
          },
        },
      },
      lsp_implementations = {
        layout = {
          preview = "main",
        },
      },
      grep = {
        layout = {
          preview = "main",
        }
      },
      command_history = {
        layout = {
          preset = "ivy",
          preview = false,
        }
      },
      commands = {
        layout = {
          preview = false,
        }
      },
    },
    ui_select = true,
    layout = {
      preview = true,
      preset = "ivy",
    },
    layouts = {
      -- Still ivy, just because some other plugins using select
      select = {
        layout = {
          box = "vertical",
          backdrop = false,
          row = -2,
          width = 0,
          min_height = 1,
          max_height = 17,
          border = "top",
          title = "{title} {live} {flags}",
          title_pos = "left",
          { win = "input", height = 1, border = "none" },
          {
            box = "horizontal",
            { win = "list", border = "none" },
            { win = "preview", title = "{preview}", width = 0.5, border = "left" },
          },
        },
      },
      ivy = {
        layout = {
          box = "vertical",
          backdrop = false,
          row = -2,
          width = 0,
          min_height = 1,
          max_height = 17,
          border = "top",
          title = "{title} {live} {flags}",
          title_pos = "left",
          { win = "input", height = 1, border = "none" },
          {
            box = "horizontal",
            { win = "list", border = "none" },
            { win = "preview", title = "{preview}", width = 0.5, border = "left" },
          },
        },
      }
    },
    win = {
      -- input window
      input = {
        keys = {
          ["<Esc>"] = { "close", mode = { "n", "i" } },
          ["<c-g>"] = { "close", mode = { "n", "i" } },
          ["<c-l>"] = { "toggle_live", mode = { "i", "n" } },
        },
      }
    },
    formatters = {
      file = {
        truncate = 80, -- truncate the file path to (roughly) this length
      },
    },
  },
  -- Terminal
  terminal = {
    win = {
      opts = {
        -- interactive = false,
        auto_close = false,
        auto_insert = false,
        start_insert = false,
      },
      bo = {
        filetype = "snacks_terminal",
      },
      wo = {},
      keys = {
        gq = "hide",
        -- gf = function(self)
        --   local f = vim.fn.findfile(vim.fn.expand("<cfile>"), "**")
        --   if f == "" then
        --     Snacks.notify.warn("No file under cursor")
        --   else
        --     self:hide()
        --     vim.schedule(function()
        --       vim.cmd("e " .. f)
        --     end)
        --   end
        -- end,
      },
    }
  }
})

local function read_zsh_history()
  local history_file = os.getenv("HOME") .. "/.zsh_history"
  local items = {}
  local idx = 1

  local file = io.open(history_file, "r")
  if not file then
    return items
  end

  for line in file:lines() do
    local cmd = line:match(";(.+)$")
    if cmd then
      table.insert(items, {
        idx = idx,
        score = idx,
        text = cmd,
        command = cmd,
      })
      idx = idx + 1
    end
  end

  file:close()
  return items
end

local function zsh_history_picker()
  local items = read_zsh_history()

  local format = function(item)
    local ret = {}
    ret[#ret + 1] = { "", "@string" }
    ret[#ret + 1] = { " " }
    ret[#ret + 1] = { item.text or "", "@file" }

    return ret
  end

  local confirm = function(picker, item)
    picker:close()
    if item then
      vim.schedule(function()
        vim.cmd("terminal")
        vim.cmd("startinsert")
        vim.api.nvim_put({item.command}, "", false, true)
      end)
    end
  end

  return Snacks.picker.pick({
    items = items,
    format = format,
    confirm = confirm,
    preview = "preview",
  })
end

vim.keymap.set('n', '<Leader><CR>', zsh_history_picker, { desc = "Zsh History" })
