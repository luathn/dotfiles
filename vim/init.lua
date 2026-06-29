require("settings")
require("pack")
require("core.utils").load_mappings("general")
require("core.utils").load_mappings("ruby_on_rails")
require("core.utils").load_mappings("term")

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "qf" },
  command = [[nnoremap <buffer> q :cclose<CR>:lclose<CR>]]
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "nvim-undotree" },
  command = [[nnoremap <buffer> q :q<CR>]]
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "ruby" },
  command = [[nnoremap <buffer> <leader>rr :term ruby %<CR>]]
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go" },
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "<leader>rr", ":sp | term go run %<CR>", { noremap = true, silent = true })
  end,
})
