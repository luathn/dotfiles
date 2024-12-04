local MiniPick = require('mini.pick')

local win_config = function()
  height = 18
  width = vim.o.columns

  return {
    anchor = 'NW',
    height = height,
    width = width,
    row = vim.o.lines - height - 4,
    col = vim.o.columns - width,
  }
end

local wipeout_cur = function()
  vim.api.nvim_buf_delete(MiniPick.get_picker_matches().current.bufnr, {})
end

local switch_picker = function()
  local query = MiniPick.get_picker_query() or {}
  MiniPick.stop()
  MiniPick.ui_select(
    vim.tbl_keys(MiniPick.registry),
    {
      prompt = 'Switch picker with query: ' .. table.concat(query, ''),
    },
    function(picker)
      vim.cmd('Pick ' .. picker)
      local transfer_query = function() MiniPick.set_picker_query(query) end
      vim.api.nvim_create_autocmd('User', { pattern = 'MiniPickStart', once = true, callback = transfer_query })
    end
  )
end

local grep_files = function()
  local items = MiniPick.get_picker_matches().all or {}
  MiniPick.stop()
  MiniPick.builtin.grep_live({ globs = items })
end

local open_explorer = function()
  local current = (MiniPick.get_picker_matches() or {}).current
  -- if current == nil then return end
  local dir_path = vim.fn.fnamemodify(current, ":h")
  -- vim.cmd(vim.fn.input('Execute: '))
  -- vim.cmd(vim.fn.input('Oil ' .. dir_path))
  MiniPick.stop()
  vim.cmd("Oil app")
end

require('mini.pick').setup({
  window = {
    config = win_config,
    prompt_cursor = '▏',
    prompt_prefix = 'Search ',
  },
  mappings = {
    caret_left    = '<C-b>',
    caret_right   = '<C-f>',
    choose_marked = '<C-CR>',
    paste         = '<C-r>',
    stop          = '<Esc>',
    scroll_left   = '<C-h>',
    scroll_down   = '<C-j>',
    scroll_up     = '<C-k>',
    scroll_right  = '<C-l>',
    -- oil           = { char = '<C-e>', func = open_explorer },
    switch        = { char = '<C-z>', func = switch_picker },
    grep_files    = { char = '<C-o>', func = grep_files },
  },
  buffers = {
    mappings = {
      wipeout = { char = '<C-d>', func = wipeout_cur }
    }
  }
})

local get_unixtime = function(buf)
  return buf.lastused
end

local get_bufs = function()
  local bufs = vim.tbl_filter(function(buf)
    return vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_get_option(buf, 'buflisted')
  end, vim.api.nvim_list_bufs())
  local buffers = {}
  for _, bufnr in ipairs(bufs) do
    table.insert(buffers, {
      bufnr = bufnr,
      lastused = vim.fn.getbufinfo(bufnr)[1].lastused,
      is_modified = vim.api.nvim_buf_get_option(bufnr, 'modified')
    })
  end

  table.sort(buffers, function(a, b)
    return get_unixtime(a) > get_unixtime(b)
  end)
  local items = {}
  for _, buf in ipairs(buffers) do
    local bufnr = buf.bufnr
    local is_modified = buf.is_modified

    local full_path = vim.api.nvim_buf_get_name(bufnr)
    local relative_path = vim.fn.fnamemodify(full_path, ':~:.')
    local flag = (is_modified == true and "+") or " "

    table.insert(items, {
      bufnr = bufnr,
      text = string.format('[%s] %s %s', bufnr, flag, relative_path),
    })
  end
  return items
end

-- -- Configure and start mini.pick
-- MiniPick.start({
--   source = {
--     items = items,
--     name = 'Buffers',
--     show = function(buf)
--       local width = vim.api.nvim_win_get_width(0)
--       local filename_width = math.floor(width * 0.4)
--       return string.format('%-' .. filename_width .. 's %s', buf.filename, buf.directory)
--     end,
--   },
--   mappings = {
--     choose = '<CR>',
--     choose_in_split = '<C-s>',
--     choose_in_tabpage = '<C-t>',
--   },
--   -- Callback function when an item is selected
--   action = function(buf)
--     vim.api.nvim_set_current_buf(buf.bufnr)
--   end,
-- })

vim.keymap.set(
  'n',
  '<C-,>',
  function()
    MiniPick.start({
      source = {
        items = get_bufs(),
        name = 'Buffers',
        mappings = { wipeout = { char = '<C-d>', func = wipeout_cur } },
      },
    })
  end
)

-- UI
local fg_bg = require("core.utils").fg_bg
local bg = require("core.utils").bg
local fg = require("core.utils").fg
local colors = require("colors").get()

bg("MiniPickNormal", colors.bg)
bg("MiniPickMatchCurrent", colors.bg_dark)

fg_bg("MiniPickBorder", colors.purple, colors.bg)
-- bg("MiniPickBorderText", colors.bg_dark)

fg_bg("MiniPickPrompt", colors.purple, colors.bg)
