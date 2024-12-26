local M = {}

-- Function to find a terminal buffer
local function find_terminal_buffer()
  return vim.tbl_filter(function(bufnr)
    return vim.bo[bufnr].buftype == 'terminal'
  end, vim.api.nvim_list_bufs())[1]
end

-- Function to find the window displaying a specific buffer
local function find_buffer_window(bufnr)
  return vim.tbl_filter(function(winid)
    return vim.api.nvim_win_get_buf(winid) == bufnr
  end, vim.api.nvim_list_wins())[1]
end

local function create_vsplit_win(buf)
  local split = vim.o.columns > 140 and 'right' or 'below'
  -- local width = math.floor(vim.o.columns * (vim.o.columns > 180 and 0.35 or 0.5))
  vim.api.nvim_open_win(buf, true, {
    split = split,
    -- width = width,
  })
  vim.cmd('wincmd =')
end

-- Function to create a new terminal
local function create_terminal()
  local buf = vim.api.nvim_create_buf(true, true)
  vim.api.nvim_set_option_value("filetype", "terminal", { buf = buf })
  create_vsplit_win(buf)
  vim.fn.termopen(vim.o.shell)
end

function M.toggle()
  local terminal_bufnr = find_terminal_buffer()

  if terminal_bufnr then
    local terminal_winid = find_buffer_window(terminal_bufnr)
    if terminal_winid then
      vim.api.nvim_win_close(terminal_winid, true)
    else
      create_vsplit_win(terminal_bufnr)
    end
  else
    create_terminal()
  end
end

return M
