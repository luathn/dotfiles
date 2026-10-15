vim.g.minibuffer = {
  dynamic_window_resize = true, -- Shrink other windows when the minibuffer is expanded
  keymaps = {
    ["<c-g>"] = "cancel",
  },
  cmd = {
    -- NOTE: minibuffer cmd is not compatible with command line plugins that force `wildtrigger()` each `wildchar` such as mini.cmdline
    enabled = false,         -- Enable command line wildmenu replacement through the minibuffer
    -- autotrigger = { "edit", "buffer" , "/", "Oil"},    -- Display completion suggestions as you type
    autotrigger = false,
    dynamic_height = false, -- Whether the completion window should shrink as items disappear.
    max_height = 12,        -- Maximum height when using the command line
  },
}

local minibuffer = require("minibuffer")

vim.ui.select = require("minibuffer.builtin.ui_select")
vim.ui.input = require("minibuffer.builtin.ui_input")

vim.keymap.set("n", "<leader><CR>", function() minibuffer.resume(true) end)
vim.keymap.set("n", "<leader>:", function() require("minibuffer.builtin.history")({ type = "cmd" }) end, { desc = "Find command history" })
vim.keymap.set("n", "<leader>?", function() require("minibuffer.builtin.history")({ type = "search" }) end, { desc = "Find command history" })
vim.keymap.set("n", "<leader>/", require("minibuffer.builtin.live-grep"), { desc = "Live grep" })
vim.keymap.set("n", "<leader>,", require("minibuffer.builtin.buffers"), { desc = "Find buffers" })
vim.keymap.set("n", "<leader><space>", require("minibuffer.builtin.files"), { desc = "Find files" })
vim.keymap.set("n", "<leader>fd", function() require("minibuffer.builtin.diagnostics")({ scope = "buffer" }) end, { desc = "Find diagnostics" })
vim.keymap.set("n", "<leader>fD", function() require("minibuffer.builtin.diagnostics")({ scope = "workspace" }) end, { desc = "Find diagnostics (workspace)" })
vim.keymap.set("n", "<leader>fo", function() require("minibuffer.builtin.oldfiles")({ cwd = vim.fn.getcwd() }) end, { desc = "Find oldfiles (cwd)" })
vim.keymap.set("n", "<leader>fO", require("minibuffer.builtin.oldfiles"), { desc = "Find oldfiles (all)" })
vim.keymap.set("n", "<leader>fq", function() require("minibuffer.builtin.list")({ type = "quickfix" }) end, { desc = "Find in quickfix" })
