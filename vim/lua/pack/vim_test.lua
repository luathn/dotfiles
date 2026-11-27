vim.pack.add({ "https://github.com/vim-test/vim-test" })

vim.g["test#strategy"] = "neovim_sticky"
vim.g["test#neovim#term_position"] = "vert"

vim.keymap.set("n", "<leader>tn", "<cmd>TestNearest<cr>", { desc = "[T]est [n]earest" })
vim.keymap.set("n", "<leader>tf", "<cmd>TestFile<cr>", { desc = "[T]est [f]ile" })
vim.keymap.set("n", "<leader>ts", "<cmd>TestSuite<cr>", { desc = "[T]est [s]uite" })
vim.keymap.set("n", "<leader>tl", "<cmd>TestLast<cr>", { desc = "[T]est [l]ast" })
vim.keymap.set("n", "<leader>tv", "<cmd>TestVisit<cr>", { desc = "[T]est [v]isit" })
