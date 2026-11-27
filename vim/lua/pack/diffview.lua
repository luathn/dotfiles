vim.pack.add({ "https://github.com/sindrets/diffview.nvim" })

require("diffview").setup({})

vim.keymap.set("n", "<leader>gd", ":DiffviewOpen ", { desc = "[G]it [d]iff" })
vim.keymap.set("n", "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", { desc = "[G]it [h]istory" })
vim.keymap.set("n", "<leader>cc", function() require("diffview.config").actions.conflict_choose("all")() end, { desc = "[C]onflict [C]hoose" })
