-- calling `setup` is optional for customization
local actions = require "fzf-lua.actions"

local get_buffer_name = function (selected)
  local bufnr = tonumber(string.match(selected[1], "%[(%d+)"))
  return vim.fn.bufname(bufnr)
end

require('fzf-lua').setup({
  winopts             = {
    -- split             = "botright 30new",  -- open in a full-width split on the bottom
    -- border         = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
    border            = { '', '', '', '', '─', '─', '─', '' },
    height            = 0.4,            -- window height
    width             = 1,            -- window width
    row               = 1,            -- window row position (0=top, 1=bottom)
    col               = 0,            -- window col position (0=left, 1=right)
    backdrop          = 100,
    preview           = {
      layout          = 'vertical',          -- horizontal|vertical|flex
      vertical        = 'up:50%',
    }
  },
  fzf_opts = {
    ['--ansi']        = '',
    ['--info']        = 'inline',
    ['--layout']      = 'reverse',
    ['--no-separator'] = '',
    ["--marker"]      = "+",
  },
  fzf_args = '--info=inline',
  keymap              = {
    fzf               = {
      ["ctrl-q"]      = "select-all+accept",
    },
  },
  files = {
    prompt = 'Files❯ ',
    file_icons        = false,         -- show file icons?
    git_icons         = false,         -- colorize file|git icons
    previewer         = false,
    cwd_prompt        = false,
    actions           = {
      ["ctrl-y"]      = function(selected)
        vim.fn.setreg('*', selected[1])
      end,
      ["ctrl-g"]      = "",
      ["ctrl-e"]      = function(selected)
        local dir_path = vim.fn.fnamemodify(selected[1], ":h")
        vim.cmd("Oil " .. dir_path)
      end,
    },
    winopts           = {
      split           = "botright 15new",  -- open in a full-width split on the bottom
    },
  },
  buffers = {
    prompt            = 'Buffers❯ ',
    no_header         = true,
    file_icons        = true,         -- show file icons?
    git_icons         = true,         -- colorize file|git icons
    sort_lastused     = true,         -- sort buffers() by last used
    show_unloaded     = true,         -- show unloaded buffers
    actions = {
      ["ctrl-d"]      = { fn = actions.buf_del, reload = true },
      ["ctrl-y"]      = function(selected)
        vim.fn.setreg('*', get_buffer_name(selected))
      end,
    },
    winopts           = {
      split           = "bot 30new",
    },
  },
  git = {
    branches = {
      cmd             = "git branch -l --sort=-committerdate --color",
      winopts           = {
        split           = "botright 15new",
        preview         = {
          hidden        = "hidden"
        }
      }
    },
  },
  grep = {
    prompt            = 'Grep❯ ',
    actions           = {
      -- ["ctrl-q"]      = actions.buf_sel_to_qf
    },
    winopts           = {
      split           = "bot 40new",
    },
  },
  commands = {
    prompt            = 'Commands❯ ',
    winopts           = {
      split           = "bot 15new",
      preview         = {
        hidden        = "hidden"
      }
    }
  },
  lsp = {
    code_actions = {
      previewer = "codeaction_native",
      preview_pager = "delta --side-by-side --width=$FZF_PREVIEW_COLUMNS --hunk-header-style='omit' --file-style='omit'",
    },
  },
  hls = {
    normal            = "TelescopeNormal",
    border            = "TelescopeNormal",
    title             = "TelescopeTitle",
    help_normal       = "TelescopeNormal",
    help_border       = "TelescopeNormal",
    preview_normal    = "TelescopeNormal",
    preview_border    = "FzfLuaPreviewBorder",
    preview_title     = "TelescopeTitle",
    -- builtin preview only
    cursor            = "Cursor",
    cursorline        = "TelescopePreviewLine",
    cursorlinenr      = "TelescopePreviewLine",
    search            = "IncSearch",
    buf_nr            = "TelescopeSelectionCaret",
    header_bind       =  "TelescopeSelectionCaret",

    scrollborder_f    = "TelescopeSelectionCaret",
    scrollborder_e    = "TelescopeNormal",
    -- backdrop          = "TelescopePreviewLine",
  },
  -- fzf_colors = true,
  fzf_colors = {
    ["fg"]            = { "fg", "TelescopeNormal" },
    ["bg"]            = { "bg", "TelescopeNormal" },
    ["hl"]            = { "fg", "TelescopeMatching" },
    ["fg+"]           = { "fg", "TelescopeSelection" },
    ["bg+"]           = { "bg", "TelescopeSelection" },
    ["hl+"]           = { "fg", "TelescopeMatching" },
    ["info"]          = { "fg", "TelescopeMultiSelection" },
    ["border"]        = { "fg", "FzfLuaBorder" },
    ["gutter"]        = { "bg", "TelescopeNormal" },
    ["prompt"]        = { "fg", "TelescopePromptPrefix" },
    ["pointer"]       = { "fg", "TelescopeSelectionCaret" },
    ["marker"]        = { "fg", "TelescopeSelectionCaret" },
    ["header"]        = { "fg", "TelescopeSelection" },
  },
  defaults            = { git_icons = false, file_icons = false },
})
