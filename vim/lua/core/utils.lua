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

-- Load mappings - inspired by NVchad

M.load_mappings = function(section, mapping_opts, source_mappings)
  vim.schedule(function()
    local mappings = source_mappings or require("mappings")[section]
    local default_opts = vim.tbl_deep_extend("force", {}, mapping_opts or {})

    for mode, mode_mappings in pairs(mappings) do
      for keybind, mapping_info in pairs(mode_mappings) do
        local opts = vim.tbl_deep_extend("force", default_opts, mapping_info.opts or {})
        opts.desc = mapping_info[2]

        vim.keymap.set(mode, keybind, mapping_info[1], opts)
      end
    end
  end)
end

M.load_keys = function(keys)
  for _, key in ipairs(keys) do
    local lhs = key[1]
    local rhs = key[2]
    if rhs then
      local mode = key.mode or "n"
      local opts = { desc = key.desc, noremap = true, silent = true }
      if key.ft then
        vim.api.nvim_create_autocmd("FileType", {
          pattern = key.ft,
          callback = function() vim.keymap.set(mode, lhs, rhs, opts) end,
        })
      else
        vim.keymap.set(mode, lhs, rhs, opts)
      end
    end
  end
end

return M
