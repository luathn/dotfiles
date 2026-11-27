vim.opt.rtp:prepend(vim.fn.expand("~/code/nvimtico"))
vim.g.nvimtico_ui_select = true

local actions = require("nvimtico.actions")
require("nvimtico").setup({
  keys = {
    ["<C-g>"] = actions.close,
    ["<C-c>"] = actions.close,
    ["<Esc>"] = actions.close,
  },
})

vim.keymap.set("n", "<leader><space>", "<cmd>Tico files<cr>")
vim.keymap.set("n", "<leader>,", "<cmd>Tico buffers<cr>")
vim.keymap.set("n", "<leader>/", "<cmd>Tico grep<cr>")
