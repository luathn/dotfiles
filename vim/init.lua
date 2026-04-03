-- local home_dir = os.getenv("HOME")
-- local node_bin = "/.asdf/installs/nodejs/18.15.0/bin"
-- vim.g.node_host_prog = home_dir .. node_bin .. "/node"
-- vim.cmd("let $PATH = '" .. home_dir .. node_bin .. ":' . $PATH")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("settings")
require("core.utils").load_mappings("general")
require("core.utils").load_mappings("ruby_on_rails")
require("core.utils").load_mappings("term")

local plugins = require("plugins")
require("lazy").setup(plugins, {})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "qf" },
  command = [[nnoremap <buffer> q :cclose<CR>:lclose<CR>]]
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
