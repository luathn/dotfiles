-- local win_config = function()
--   height = 18
--   width = vim.o.columns
--
--   return {
--     anchor = 'NW',
--     height = height,
--     width = width,
--     row = vim.o.lines - height - 4,
--     col = vim.o.columns - width,
--   }
-- end
local win_config = function()
  height = math.floor(0.3 * vim.o.lines)
  width = vim.o.columns > 170 and math.floor(0.618 * vim.o.columns) or vim.o.columns
  return {
    anchor = 'NW',
    height = height,
    width = width,
    row = math.floor(0.5 * (vim.o.lines - height)),
    col = math.floor(0.5 * (vim.o.columns - width)),
  }
end

-- Custom functions
local wipeout_cur = function()
  local bufnr = MiniPick.get_picker_matches().current.bufnr
  vim.api.nvim_buf_delete(bufnr, {})
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

local toggle_switch_picker = function()
  local query = MiniPick.get_picker_query() or {}
  local current_picker = MiniPick.get_picker_opts().source.name
  local next_picker = string.lower(current_picker) == 'buffers' and { 'builtin', 'files' } or { 'registry', 'buffers' }
  MiniPick.stop()
  MiniPick[next_picker[1]][next_picker[2]]()
  local transfer_query = function() MiniPick.set_picker_query(query) end
  vim.api.nvim_create_autocmd('User', { pattern = 'MiniPickStart', once = true, callback = transfer_query })
end

local grep_files = function()
  local items = MiniPick.get_picker_matches().all or {}
  MiniPick.stop()
  MiniPick.builtin.grep_live({ globs = items })
end

local open_explorer = function()
  local current = (MiniPick.get_picker_matches() or {}).current
  if current == nil then return end
  local dir_path = vim.fn.fnamemodify(current, ":h")
  MiniPick.stop()

  vim.schedule(function()
    require('oil').open(dir_path)
  end)
end

local yank_path = function()
  local current = (MiniPick.get_picker_matches() or {}).current
  if current == nil then return end
  local path = current.name or current

  MiniPick.stop()
  vim.fn.setreg('*', path)
end

require('mini.pick').setup({
  window = {
    config = win_config,
    prompt_caret = '▏',
    prompt_prefix = ' ',
  },
  mappings = {
    caret_left    = '<C-b>',
    caret_right   = '<C-f>',
    choose_marked = '<C-CR>',
    paste         = '<C-r>',
    stop          = '<C-g>',
    scroll_left   = '<C-h>',
    scroll_down   = '<C-j>',
    scroll_up     = '<C-k>',
    scroll_right  = '<C-l>',
    explorer      = { char = '<C-e>', func = open_explorer },
    switch        = { char = "<C-'>", func = switch_picker },
    toggle_switch = { char = "<C-;>", func = toggle_switch_picker },
    grep_files    = { char = '<C-o>', func = grep_files },
    pick_stop     = { char = '<Esc>', func = function() MiniPick.stop() end },
    yank_path     = { char = '<C-y>', func = yank_path },
  },
})

vim.ui.select = MiniPick.ui_select

-- Sorted buffers
local get_unixtime = function(buf)
  return buf.lastused
end

MiniPick.registry.sorted_buffers = function()
  local bufs = vim.tbl_filter(function(buf)
    return vim.api.nvim_buf_is_valid(buf)
        and vim.api.nvim_buf_get_option(buf, 'buflisted')
        and vim.api.nvim_buf_get_name(buf) ~= ''
  end, vim.api.nvim_list_bufs()) or vim.api.nvim_list_bufs()

  -- Add lastused and modified to buffers
  local buffers = {}
  for _, bufnr in ipairs(bufs) do
    table.insert(buffers, {
      bufnr = bufnr,
      lastused = vim.fn.getbufinfo(bufnr)[1].lastused,
      modified = vim.api.nvim_buf_get_option(bufnr, 'modified')
    })
  end

  table.sort(buffers, function(a, b)
    return get_unixtime(a) > get_unixtime(b)
  end)

  local current_bufnr = table.remove(buffers, 1)
  table.insert(buffers, current_bufnr)

  -- Transform to mini pick format
  local items = {}
  for _, buf in ipairs(buffers) do
    local bufnr = buf.bufnr
    local buf_name = vim.fn.fnamemodify(vim.fs.normalize(vim.api.nvim_buf_get_name(bufnr)), ':.')
    local flag = (buf.modified == true and "+") or " "

    table.insert(items, {
      bufnr = bufnr,
      text = string.format('%s %s', flag, buf_name),
      name = buf_name,
    })
  end

  MiniPick.start({
    source = {
      items = items,
      name = 'Buffers',
    },
    mappings = { wipeout = { char = '<C-d>', func = wipeout_cur } },
  })
end

-- UI
-- local fg_bg = require("core.utils").fg_bg
-- local bg = require("core.utils").bg
-- local fg = require("core.utils").fg
-- local colors = require("colors").get()
--
-- bg("MiniPickNormal", colors.bg)
-- bg("MiniPickMatchCurrent", colors.bg_dark)
--
-- fg_bg("MiniPickBorder", colors.purple, colors.bg)
-- -- bg("MiniPickBorderText", colors.bg_dark)
--
-- fg_bg("MiniPickPrompt", colors.purple, colors.bg)
