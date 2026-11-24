require('mini.git').setup({
  command = {
    split = "auto",
  }
})

local map_local = vim.schedule_wrap(function(data)
  if not vim.api.nvim_buf_is_valid(data.buf) then return end
  local buf_name = vim.api.nvim_buf_get_name(data.buf)
  if not vim.startswith(buf_name, 'minigit://') then return end
  vim.keymap.set({ 'n' }, 'q', "<Cmd>q<CR>", { buffer = data.buf, desc = 'Quit mini git window' })
  vim.keymap.set({ 'n', 'x' }, '<CR>', "<Cmd>lua MiniGit.show_at_cursor({ split='vertical' })<CR>",
    { buffer = data.buf, desc = 'Show at cursor' })
  vim.keymap.set({ 'n', 'x' }, '<leader>gs', "<Cmd>lua MiniGit.show_diff_source({ split='vertical' })<CR>",
    { buffer = data.buf, desc = 'Show diff source' })
end)
-- Alternative is to map for `User` `MiniGitCommandSplit` event, but
-- it would not trigger when buffer is created with `show_xxx()` functions
vim.api.nvim_create_autocmd('BufNew', { callback = map_local })

vim.keymap.set('x', '<leader>gl', "<Cmd>lua MiniGit.show_range_history({ split='vertical' })<CR>",
  { desc = 'Show range history' })
