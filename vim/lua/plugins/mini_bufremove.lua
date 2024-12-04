require('mini.bufremove').setup()

local remove_other_buffers = function()
  local current_buf = vim.api.nvim_get_current_buf()
  local all_bufs = vim.api.nvim_list_bufs()

  for _, buf in ipairs(all_bufs) do
    if buf ~= current_buf then
      MiniBufremove.delete(buf, false)
    end
  end
end

local remove_all_buffers = function()
  local all_bufs = vim.api.nvim_list_bufs()

  for _, buf in ipairs(all_bufs) do
    MiniBufremove.delete(buf, false)
  end
end

vim.keymap.set('n', '<leader>bo', function() remove_other_buffers() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>bD', function() remove_all_buffers() end, { noremap = true, silent = true })
