local dap = require("dap")
local dapgo = require('dap-go')

-- Opens on session start, closes when it ends
require("dap-view").setup({
  auto_toggle = true,
  hover = {
    border = "single",
  },
})

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
