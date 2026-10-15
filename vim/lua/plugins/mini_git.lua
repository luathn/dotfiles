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

-- local align_blame = function(au_data)
--   if au_data.data.git_subcommand ~= 'blame' then return end
--
--   -- Align blame output with source
--   local win_src = au_data.data.win_source
--   vim.wo.wrap = false
--   vim.fn.winrestview({ topline = vim.fn.line('w0', win_src) })
--   vim.api.nvim_win_set_cursor(0, { vim.fn.line('.', win_src), 0 })
--
--   -- Bind both windows so that they scroll together
--   vim.wo[win_src].scrollbind, vim.wo.scrollbind = true, true
-- end
--
-- local au_opts = { pattern = 'MiniGitCommandSplit', callback = align_blame }
-- vim.api.nvim_create_autocmd('User', au_opts)
