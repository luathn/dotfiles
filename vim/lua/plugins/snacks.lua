return {
  picker = {
    actions = {
      switch_to_buffers = function(picker, _)
        local pattern = picker.input.filter.pattern
        picker:close()
        Snacks.picker.buffers({ pattern = pattern })
      end,
      switch_to_smart = function(picker, _)
        local pattern = picker.input.filter.pattern
        picker:close()
        Snacks.picker.smart({ pattern = pattern })
      end,
    },
    sources = {
      smart = {
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
              ["<c-;>"] = { "switch_to_smart", mode = { "n", "i" } },
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
          height = 0.35,
          min_height = 17,
          max_height = 17,
          box = "vertical",
          border = "rounded",
          title_pos = "center",
          { win = "input", height = 1, border = "bottom" },
          { win = "list", border = "none" },
          { win = "preview", height = 0.4, border = "top" },
        }
      },
    },
    win = {
      -- input window
      input = {
        keys = {
          ["<Esc>"] = { "close", mode = { "n", "i" } },
        },
      }
    },
  }
}
