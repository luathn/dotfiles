vim.pack.add({ "https://github.com/coder/claudecode.nvim" })

require("claudecode").setup({
  terminal = {
    split_width_percentage = 0.45,
    provider = "native",
  },
  diff_opts = {
    open_in_new_tab = true,
  },
})

vim.keymap.set({ "n", "t", "i" }, "<C-/>", "<cmd>ClaudeCode<cr>", { desc = "Toggle Claude" })
vim.keymap.set("n", "<leader>aa", "<cmd>ClaudeCode<cr>", { desc = "Toggle Claude" })
vim.keymap.set("n", "<leader>af", "<cmd>ClaudeCodeFocus<cr>", { desc = "Focus Claude" })
vim.keymap.set("n", "<leader>ar", "<cmd>ClaudeCode --resume<cr>", { desc = "Resume Claude" })
vim.keymap.set("n", "<leader>ac", "<cmd>ClaudeCode --continue<cr>", { desc = "Continue Claude" })
vim.keymap.set("n", "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", { desc = "Select Claude model" })
vim.keymap.set("n", "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", { desc = "Add current buffer" })
vim.keymap.set("v", "<leader>as", "<cmd>ClaudeCodeSend<cr>", { desc = "Send to Claude" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "NvimTree", "neo-tree", "oil", "minifiles" },
  callback = function(args)
    vim.keymap.set("n", "<leader>as", "<cmd>ClaudeCodeTreeAdd<cr>", { buffer = args.buf, desc = "Add file" })
  end,
})
