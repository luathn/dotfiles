require('nvim-devdocs').setup({
  telescope = {
    previewer = false,
  },
  after_open = function(bufnr)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'q', ':close<CR>', {})
  end
})
