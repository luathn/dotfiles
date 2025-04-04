local bg = require("core.utils").bg
local fg = require("core.utils").fg
local colors = require("catppuccin.palettes").get_palette "frappe"

bg("SnacksPickerInput", colors.base)
fg("SnacksPickerDir", colors.text)

require("snacks").setup({
  picker = {
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
    },
    sources = {
      files = {
        win = {
          input = {
            keys = {
              ["<c-;>"] = { "switch_to_buffers", mode = { "n", "i" } },
            },
          },
        }
      },
      buffers = {
        finder = "buffers",
        format = "buffer",
        current = false,
        sort_lastused = true,
        win = {
          input = {
            keys = {
              ["<c-x>"] = { "bufdelete", mode = { "n", "i" } },
              ["<c-;>"] = { "switch_to_files", mode = { "n", "i" } },
            },
          },
        },
      },
      grep_buffers = {
        layout = {
          preview = "main",
          preset = "ivy",
        }
      },
      command_history = {
        layout = {
          preset = "select",
        }
      }
    },
    ui_select = true,
    layout = {
      preview = false,
      preset = "select",
    },
    layouts = {
      select = {
        layout = {
          backdrop = false,
          width = 0.5,
          min_width = 100,
          height = 0.7,
          min_height = 17,
          max_height = 17,
          box = "vertical",
          border = "rounded",
          title_pos = "center",
          { win = "input", height = 1, border = "bottom" },
          { win = "list", border = "none" },
          { win = "preview", height = 0.5, border = "top" },
        }
      },
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
  -- terminal = {
  --   bo = {
  --     filetype = "snacks_terminal",
  --   },
  --   wo = {},
  --   keys = {
  --     gq = "hide",
  --     gf = function(self)
  --       local f = vim.fn.findfile(vim.fn.expand("<cfile>"), "**")
  --       if f == "" then
  --         Snacks.notify.warn("No file under cursor")
  --       else
  --         self:hide()
  --         vim.schedule(function()
  --           vim.cmd("e " .. f)
  --         end)
  --       end
  --     end,
  --     term_normal = {
  --       "<esc>",
  --       function(self)
  --         self.esc_timer = self.esc_timer or (vim.uv or vim.loop).new_timer()
  --         if self.esc_timer:is_active() then
  --           self.esc_timer:stop()
  --           vim.cmd("stopinsert")
  --         else
  --           self.esc_timer:start(200, 0, function() end)
  --           return "<esc>"
  --         end
  --       end,
  --       mode = "t",
  --       expr = true,
  --       desc = "Double escape to normal mode",
  --     },
  --   },
  -- }
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
