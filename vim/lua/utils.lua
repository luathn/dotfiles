local M = {}

local cmd = vim.cmd

-- Highlights functions

-- Define bg color
-- @param group Group
-- @param color Color

M.bg = function(group, color)
   cmd("hi " .. group .. " guibg=" .. color)
end

-- Define fg color
-- @param group Group
-- @param color Color
M.fg = function(group, color)
   cmd("hi " .. group .. " guifg=" .. color)
end

-- Define bg and fg color
-- @param group Group
-- @param fgcol Fg Color
-- @param bgcol Bg Color
M.fg_bg = function(group, fgcolor, bgcolor)
   cmd("hi " .. group .. " guifg=" .. fgcolor .. " guibg=" .. bgcolor)
end

return M
