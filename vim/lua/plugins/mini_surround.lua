require("mini.surround").setup({
  mappings = {
    add = 'ys',
    delete = 'ds',
    -- find = '',
    -- find_left = '',
    -- highlight = 'sh',
    replace = 'cs',
    -- update_n_lines = '',
    -- -- Add this only if you don't want to use extended mappings
    -- suffix_last = 'p',
    -- suffix_next = 'n',
  },
  -- n_lines = 20,
  search_method = 'cover_or_next',
})
--
vim.keymap.del('x', 'ys')
vim.keymap.set('x', 'S', [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })
