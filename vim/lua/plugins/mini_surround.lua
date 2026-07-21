require("mini.surround").setup({
  mappings = {
    add = 'ys',
    delete = 'ds',
    replace = 'cs',
  },
  search_method = 'cover_or_next',
})
--
vim.keymap.del('x', 'ys')
vim.keymap.set('x', 'S', [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })
