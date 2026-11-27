vim.pack.add({
  "https://github.com/mfussenegger/nvim-dap",
  "https://github.com/leoluz/nvim-dap-go",
})

local dap = require("dap")
local dapgo = require('dap-go')

-- Setup for Golang
dap.configurations.go = {
  {
    type = "go",
    name = "Launch project main",
    request = "launch",
    program = "${workspaceFolder}/main.go",
  },
}

dapgo.setup({
  delve = {
    path = "dlv",
    initialize_timeout_sec = 20,
    port = "${port}",
    args = {},
    build_flags = {},
    detached = vim.fn.has("win32") == 0,
    cwd = nil,
  },
  tests = {
    verbose = false,
  },
})

vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
vim.keymap.set("n", "<leader>dC", dap.run_to_cursor, { desc = "Run to Cursor" })
vim.keymap.set("n", "<leader>dT", dap.terminate, { desc = "Terminate" })
vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Step [o]ut" })
vim.keymap.set("n", "<leader>dn", dap.step_over, { desc = "Step [n]ext" })
vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step [i]nto" })
vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Run [l]ast" })
vim.keymap.set("n", "<leader>dd", dap.repl.toggle, { desc = "Toggle REPL" })
vim.keymap.set("n", "<leader>dt", dapgo.debug_test, { desc = "Debug test" })
vim.keymap.set({ "n", "v" }, "<leader>de", function() require("dap.ui.widgets").preview() end, { desc = "[E]valuate Expression" })
vim.keymap.set("n", "<leader>ds", function()
  local w = require("dap.ui.widgets")
  w.sidebar(w.scopes).open()
end, { desc = "[S]copes" })
