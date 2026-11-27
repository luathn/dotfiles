vim.pack.add({ "https://github.com/neogitorg/neogit" })

local neogit = require("neogit")

neogit.setup {
  disable_insert_on_commit = true,
  kind = "auto",
  commit_editor = {
    kind = "split",
  },
  signs = { section = { "", "" }, item = { "", "" }, hunk = { "+", "-" } },
  mappings = {
    popup = {
      ["l"] = false,
      ["L"] = "LogPopup",
      ["p"] = false,
      ["F"] = "PullPopup",
      ["v"] = false,
      ["T"] = "RevertPopup",
      ["w"] = false,
      ["W"] = "WorktreePopup",
    },
  },
}

vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "[G]it status" })
vim.keymap.set("n", "<leader>gL", "<cmd>Neogit log<cr>", { desc = "[G]it [l]og" })
vim.keymap.set("n", "<leader>gb", "<cmd>Neogit branch<cr>", { desc = "[G]it [b]ranch" })
vim.keymap.set("n", "<leader>gm", "<cmd>AiCommit<cr>", { desc = "[G]it commit [m]essage" })
