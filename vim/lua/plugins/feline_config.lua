local colors = require("colors").get()

local components = {
  active = {},
  inactive = {}
}
table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.inactive, {})
table.insert(components.inactive, {})

table.insert(components.active[1], {
  provider = 'vi_mode',
  hl = function()
    return {
      name = require('feline.providers.vi_mode').get_mode_highlight_name(),
      fg = require('feline.providers.vi_mode').get_mode_color(),
      style = 'bold'
    }
  end,
  right_sep = ' ',
})

table.insert(components.active[1], {
  provider = 'git_branch',
  -- enabled = function(winid)
  --   return vim.api.nvim_win_get_width(winid) > 70
  -- end,
  hl = {
    fg = colors.purple,
    bg = colors.bg,
  },
  icon = "  ",
})

require('feline').setup({
  colors = {
    bg = colors.bg,
    fg = colors.fg,
  },
   components = components,
})
