-- Normal
vim.keymap.set("n", "gp", "`[v`]", { desc = "Select last changed text" })
vim.keymap.set("n", "gyn", ":let @+=expand('%:t')<cr>", { desc = "[Y]ank [n]ame" })
vim.keymap.set("n", "gys", ":let @+=expand('%')<cr>", { desc = "[Y]ank [s]hort path" })
vim.keymap.set("n", "gyp", ":let @+=expand('%:h')<cr>", { desc = "[Y]ank [p]arent dir" })
vim.keymap.set("n", "gyf", ":let @+=expand('%:p')<cr>", { desc = "[Y]ank [f]ull path" })
vim.keymap.set("n", "<leader>tc", "<cmd>tabnew<cr>", { desc = "[T]ab [c]reate" })
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<cr>", { desc = "[T]ab close [x]" })
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "[B]uffer [d]elete" })
vim.keymap.set("n", "<leader>bD", "<cmd>%bdelete<cr>", { desc = "[B]uffer [D]elete all" })
vim.keymap.set("n", "<esc>", ":noh<cr><esc>", { desc = "No highlight" })
vim.keymap.set("n", "<leader>oq", "<cmd>copen<cr>", { desc = "[O]pen [q]uickfix" })
vim.keymap.set("n", "<leader>ol", "<cmd>lopen<cr>", { desc = "[O]pen [l]ocation list" })
vim.keymap.set("n", "<leader><cr>", "<cmd>terminal<cr><cmd>startinsert<cr>", { desc = "Open new terminal" })

-- Window resize
vim.keymap.set("n", "<C-.>", "<Nop>")
vim.keymap.set("n", "<C-w>.", "<C-w>10>")
vim.keymap.set("n", "<C-w><C-.>", "<C-w>10>")
vim.keymap.set("n", "<C-w>,", "<C-w>10<")
vim.keymap.set("n", "<C-w><C-,>", "<C-w>10<")
vim.keymap.set("n", "<C-w>-", "<C-w>5-")
vim.keymap.set("n", "<C-w>+", "<C-w>5+")
vim.keymap.set("n", "<C-w>m", "<C-w>5+<C-w>15>")

-- Treesitter selection
vim.keymap.set("x", "<cr>", "<cmd>lua require('vim.treesitter._select').select_parent(vim.v.count1)<cr>")
vim.keymap.set("x", "<bs>", "<cmd>lua require('vim.treesitter._select').select_child(vim.v.count1)<cr>")

-- Escape
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("t", "jk", "<C-\\><C-n>")

-- Command line (Emacs style)
vim.keymap.set("c", "<C-b>", "<Left>")
vim.keymap.set("c", "<C-f>", "<Right>")
vim.keymap.set("c", "<M-b>", "<S-Left>")
vim.keymap.set("c", "<M-f>", "<S-Right>")
vim.keymap.set("c", "<C-a>", "<Home>")
vim.keymap.set("c", "<C-e>", "<End>")
