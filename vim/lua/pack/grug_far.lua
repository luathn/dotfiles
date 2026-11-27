vim.pack.add({ "https://github.com/MagicDuck/grug-far.nvim" })

require('grug-far').setup({
  minSearchChars = 3,
  prefills = {
    flags = '-i',
  },
  keymaps = {
    close = { n = 'q' },
    abort = { n = '<c-g>' },
    historyOpen = { n = '<localleader>h' },
  },
})

vim.keymap.set("n", "<leader>ss", function() require("grug-far").open({}) end, { desc = "[S]each open" })
vim.keymap.set("n", "<leader>sw", function()
  require("grug-far").open({ startInInsertMode = false, prefills = { search = vim.fn.expand("<cword>") } })
end, { desc = "[S]each [w]ord" })
vim.keymap.set("v", "<leader>sw", ":<C-u>lua require('grug-far').with_visual_selection({ startInInsertMode = false })<cr>", { desc = "[S]each [w]ord" })
