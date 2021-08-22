local gl = require('galaxyline')
local colors = require('galaxyline.theme').default
-- Light color
-- local colors = {
--   bg = '#ebebeb',
--   fg = '#666666',
--   yellow = '#ECBE7B',
--   cyan = '#008080',
--   darkblue = '#081633',
--   green = '#98be65',
--   orange = '#FF8800',
--   violet = '#a9a1e1',
--   magenta = '#c678dd',
--   blue = '#51afef';
--   red = '#ec5f67';
-- }

-- Tokyonight
local colors = require("tokyonight.colors").setup()
colors.fg = colors.fg_dark
colors.fg_transparent = "NONE"
colors.bg_transparent = "NONE"

local condition = require('galaxyline.condition')
local gls = gl.section
gl.short_line_list = {'NvimTree', 'vista', 'dbui', 'packer', 'fern'}

table.insert(gls.left, {
  RainbowRed = {
    provider = function() return '▊ ' end,
    highlight = {colors.blue, colors.bg}
  },
})

table.insert(gls.left, {
  ViMode = {
    provider = function()
      -- auto change color according the vim mode
      local mode_color = {n = colors.red, i = colors.green, v=colors.blue,
                          [''] = colors.blue, V=colors.blue,
                          c = colors.magenta, no = colors.red, s = colors.orange,
                          S=colors.orange, [''] = colors.orange,
                          ic = colors.yellow, R = colors.cyan, Rv = colors.cyan,
                          cv = colors.red, ce=colors.red, r = colors.cyan,
                          rm = colors.cyan, ['r?'] = colors.cyan,
                          ['!']  = colors.red, t = colors.red}
      vim.api.nvim_command('hi GalaxyViMode guifg='..mode_color[vim.fn.mode()] ..' guibg='..colors.bg)
      return '  '
    end,
  },
})

table.insert(gls.left, {
  GitIcon = {
    provider = function() return '' end,
    condition = condition.check_git_workspace and condition.hide_in_width,
    highlight = {colors.magenta, colors.bg, 'bold'},
    separator = ' ',
    separator_highlight = {colors.fg_transparent, colors.bg},
  }
})

table.insert(gls.left, {
  GitBranch = {
    provider = 'GitBranch',
    condition = condition.check_git_workspace and condition.hide_in_width,
    highlight = {colors.magenta, colors.bg, 'bold'},
    separator = ' ',
    separator_highlight = {colors.fg_transparent, colors.bg},
  }
})

table.insert(gls.left, {
  RightRounded = {
    provider = function () return ' ' end,
    highlight = {colors.bg, colors.bg_transparent}
  }
})

table.insert(gls.left,{
  FileIcon = {
    provider = 'FileIcon',
    condition = condition.buffer_not_empty,
    highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color, colors.bg_transparent},
  },
})

table.insert(gls.left, {
  FileName = {
    provider = function()
      local squeeze_width  = vim.fn.winwidth(0) / 2
      if squeeze_width > 50 then
        return vim.fn.expand('%')
      end
      return vim.fn.pathshorten(vim.fn.expand('%'))
    end,
    condition = condition.buffer_not_empty,
    highlight = {colors.fg, colors.bg_transparent, 'bold'},
    separator = ' ',
    separator_highlight = {colors.fg_transparent, colors.bg_transparent},
  }
})

table.insert(gls.left, {
  DiagnosticError = {
    provider = 'DiagnosticError',
    icon = '  ',
    highlight = {colors.red, colors.bg_transparent}
  }
})

table.insert(gls.left, {
  DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    icon = '  ',
    highlight = {colors.yellow, colors.bg_transparent},
  }
})

table.insert(gls.left, {
  DiagnosticHint = {
    provider = 'DiagnosticHint',
    icon = '  ',
    highlight = {colors.cyan, colors.bg_transparent},
  }
})

table.insert(gls.left, {
  DiagnosticInfo = {
    provider = 'DiagnosticInfo',
    icon = '  ',
    highlight = {colors.blue, colors.bg_transparent},
  }
})

table.insert(gls.right, {
  FileEncode = {
    provider = 'FileEncode',
    condition = condition.hide_in_width,
    highlight = {colors.fg, colors.bg_transparent},
    separator = ' ',
    separator_highlight = {colors.fg_transparent, colors.bg_transparent},
  }
})

table.insert(gls.right, {
  FileFormat = {
    provider = 'FileFormat',
    condition = condition.hide_in_width,
    highlight = {colors.fg, colors.bg_transparent},
    separator = '  ',
    separator_highlight = {colors.fg_transparent, colors.bg_transparent},
  }
})

table.insert(gls.right, {
  LeftRounded = {
    provider = function () return '' end,
    highlight = {colors.bg, colors.bg_transparent},
    separator = '  ',
    separator_highlight = {colors.fg_transparent, colors.bg_transparent},
  }
})

table.insert(gls.right, {
  LineInfo = {
    provider = 'LineColumn',
    highlight = {colors.fg, colors.bg},
    separator = ' ',
    separator_highlight = {colors.fg_transparent, colors.bg},
  },
})

table.insert(gls.right, {
  PerCent = {
    provider = 'LinePercent',
    highlight = {colors.fg, colors.bg, 'bold'},
    separator = ' ',
    separator_highlight = {colors.fg_transparent, colors.bg},
  }
})

-- Short line
table.insert(gls.short_line_left, {
  BufferType = {
    provider = 'FileTypeName',
    highlight = {colors.blue, colors.bg_transparent, 'bold'},
    separator = ' ',
    separator_highlight = {colors.fg_transparent, colors.bg_transparent},
  }
})

table.insert(gls.short_line_left, {
  SFileName = {
    provider = 'SFileName',
    condition = condition.buffer_not_empty,
    highlight = {colors.fg, colors.bg_transparent, 'bold'},
  }
})

table.insert(gls.short_line_right, {
  BufferIcon = {
    provider = 'BufferIcon',
    highlight = {colors.fg, colors.bg_transparent},
  }
})

-- local mode_color = function()
--   local mode_colors = {
--     n = colors.green,
--     i = colors.blue,
--     c = colors.orange,
--     V = colors.magenta,
--     [''] = colors.magenta,
--     v = colors.magenta,
--     R = colors.red,
--   }
--   local color = mode_colors[vim.fn.mode()]
--   if color == nil then
--     color = colors.red
--   end
--   return color
-- end

-- table.insert(gls.left, {
--   ViMode = {
--     provider = function()
--       local alias = {
--         n = 'NORMAL',
--         i = 'INSERT',
--         c = 'COMMAND',
--         V = 'VISUAL',
--         [''] = 'VISUAL',
--         v = 'VISUAL',
--         R = 'REPLACE',
--       }
--       vim.api.nvim_command('hi GalaxyViMode gui=bold guibg='..mode_color() ..' guifg=#111111')
--       local alias_mode = alias[vim.fn.mode()]
--       if alias_mode == nil then
--         alias_mode = vim.fn.mode()
--       end
--       return '  '..alias_mode
--     end,
--     highlight = { colors.bg_transparent, colors.section_bg },
--   },
-- })

-- table.insert(gls.left, {
--   ModeSepara = {
--     provider = function ()
--       vim.api.nvim_command('hi GalaxyModeSepara gui=bold guibg='..colors.bg ..' guifg='..mode_color())
--       return ' '
--     end,
--   }
-- })

-- table.insert(gls.right, {
--   ShowLspClient = {
--     provider = 'GetLspClient',
--     condition = function ()
--       local tbl = {['dashboard'] = true, ['']=true}
--       if tbl[vim.bo.filetype] then
--         return false
--       end
--       return true
--     end,
--     icon = ' LSP:',
--     highlight = {colors.fg, colors.bg_transparent, 'bold'}
--   }
-- })

-- table.insert(gls.right, {
--   DiffAdd = {
--     provider = 'DiffAdd',
--     condition = condition.hide_in_width,
--     icon = '  ',
--     highlight = {colors.green, colors.bg_transparent},
--   }
-- })

-- table.insert(gls.right, {
--   DiffModified = {
--     provider = 'DiffModified',
--     condition = condition.hide_in_width,
--     icon = ' 柳',
--     highlight = {colors.orange, colors.bg_transparent},
--   }
-- })

-- table.insert(gls.right, {
--   DiffRemove = {
--     provider = 'DiffRemove',
--     condition = condition.hide_in_width,
--     icon = '  ',
--     highlight = {colors.red, colors.bg_transparent},
--   })
-- }
