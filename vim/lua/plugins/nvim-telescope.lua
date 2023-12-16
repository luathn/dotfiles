local actions = require("telescope.actions")

require("telescope").setup{
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-l>"] = actions.cycle_history_next,
        ["<C-h>"] = actions.cycle_history_prev,
        ["<C-d>"] = actions.delete_buffer,
        ["<C-s>"] = actions.select_horizontal,
        -- ["<C-w>"] = actions.send_selected_to_qflist + actions.open_qflist,
      },
      n = {
        ["<C-c>"] = actions.close,
        ["<C-d>"] = actions.delete_buffer,
        ["dd"] = actions.delete_buffer,
      },
    },
    history = {
      limit = 10
    },
    border = true,
    layout_strategy = "vertical",
    layout_config = {
      anchor = "S",
      height = 0.6,
      width = vim.o.columns,
      prompt_position = "top",
      preview_height = 0.4, -- 60% of available lines
    },
    sorting_strategy = "ascending",
    prompt_title = false,
    prompt_prefix = "  ",
    selection_caret = " ",
    -- multi_icon = "󰄭",
    entry_prefix = "  ",
    previewer = true,
    file_ignore_patterns = {
      "node_modules"
    },
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
  },
  pickers = {
    find_files = {
      previewer = false,
    },
    git_branches = {
    },
    buffers = {
      sort_mru = true,
      previewer = false,
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    },
  }
}

require("telescope").load_extension("fzf")

_G.no_preview = {
  border = true,
  layout_strategy = "horizontal",
  layout_config = {
    height = 0.5,
    width = 0.6,
    prompt_position = "top",
  },
  sorting_strategy = "ascending",
  prompt_title = false,
  previewer = false,
}

_G.half_screen = {
  border = true,
  layout_strategy = "vertical",
  layout_config = {
    anchor = "S",
    height = 0.6, -- maximally available lines
    width = vim.o.columns, -- maximally available columns
    prompt_position = "top",
    preview_height = 0.5, -- 60% of available lines
  },
  sorting_strategy = "ascending",
  prompt_title = "abc",
  previewer = true,
}

_G.my_theme = {
  border = true,
  layout_strategy = "vertical",
  layout_config = {
    height = vim.o.lines, -- maximally available lines
    width = vim.o.columns, -- maximally available columns
    prompt_position = "top",
    preview_height = 0.6, -- 60% of available lines
  },
  sorting_strategy = "ascending",
  prompt_title = false,
  previewer = true,
}

_G.current_buffer = {
  search_dirs = { vim.fn.expand("%:h") }
}

local fg_bg = require("core.utils").fg_bg
local bg = require("core.utils").bg
local colors = require("colors").get()

bg("TelescopeNormal", colors.bg_dark)
fg_bg("TelescopeBorder", colors.bg_dark, colors.bg_dark)

fg_bg("TelescopePromptBorder", colors.bg_light, colors.bg_light)
fg_bg("TelescopePromptNormal", colors.fg, colors.bg_light)
fg_bg("TelescopePromptPrefix", colors.red, colors.bg_light)


fg_bg("TelescopePreviewTitle", colors.bg, colors.green)
fg_bg("TelescopePromptTitle", colors.bg, colors.purple)
fg_bg("TelescopeResultsTitle", colors.bg_dark, colors.bg_dark)

bg("TelescopeSelection", colors.bg_light)
