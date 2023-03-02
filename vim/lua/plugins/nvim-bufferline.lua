local colors = require("colors").get()

-- Configs
require"bufferline".setup {
  options = {
    mode = "buffers",
    numbers = "none",
    -- close_command = "bdelete! %d",       -- can be a string | function, see "Mouse actions"
    -- right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
    -- left_mouse_command = "buffer %d",    -- can be a string | function, see "Mouse actions"
    -- middle_mouse_command = nil,          -- can be a string | function, see "Mouse actions"
    buffer_close_icon= "",
    modified_icon = "●",
    close_icon = "",
    left_trunc_marker = "",
    right_trunc_marker = "",
    max_name_length = 20,
    max_prefix_length = 15, -- prefix used when a buffer is deduplicated
    truncate_names = true,
    tab_size = 22,
    diagnostics = false,
    diagnostics_indicator = function(count, level, diagnostics_dict)
      return "("..count..")"
    end,
    -- NOTE: this will be called a lot so don"t do any heavy processing here
    custom_filter = function(buf_number)
      -- filter out filetypes you don"t want to see
      if vim.bo[buf_number].filetype ~= "NeogitStatus" then
        return true
      end
      -- filter out by buffer name
      if vim.fn.bufname(buf_number) ~= "NeogitStatus" then
        return true
      end
      -- filter out based on arbitrary rules
      -- e.g. filter out vim wiki buffer from tabline in your work repo
      -- if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
      --   return true
      -- end
    end,
    offsets = {
      {
          filetype = "NvimTree",
          text = "EXPLORER",
          text_align = "left",
          separator = false,
      }
    },
    color_icons = true,
    get_element_icon = function(element)
      -- element consists of {filetype: string, path: string, extension: string, directory: string}
      -- This can be used to change how bufferline fetches the icon
      -- for an element e.g. a buffer or a tab.
      -- e.g.
      local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = false })
      return icon, hl
    end,
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    show_duplicate_prefix = true,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    separator_style = { "", "" },
    enforce_regular_tabs = false,
    always_show_bufferline = true,
    sort_by = "insert_after_current",
    groups = {
      items = {
        require("bufferline.groups").builtin.pinned:with({ icon = "" })
      }
    }
  },
  highlights = {
    fill = {
      bg = colors.bg_dark,
    },
    background = {
      bg = colors.bg_dark,
      fg = colors.fg_darker
    },
    indicator_selected = {
      fg = colors.blue,
      bg = colors.bg
    },
    duplicate_selected = {
      bg = "NONE",
    },
    duplicate = {
      bg = colors.bg
    },
    close_button = {
      bg = colors.bg_dark
    },
    tab_close = {
      bg = colors.bg_light,
      fg = "NONE"
    },
    tab = {
      fg = colors.fg_darker,
      bg = colors.bg
    },
    tab_separator = {
      fg = colors.bg,
      bg = colors.bg,
    },
    tab_selected = {
      fg = colors.bg_dark,
      bg = colors.blue
    },
    tab_separator_selected = {
      fg = colors.blue,
      bg = colors.blue,
    },
  }
}
