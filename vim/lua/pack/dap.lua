local dap = require("dap")
local dapui = require("dapui")
local dapgo = require('dap-go')

dapui.setup({})

-- Auto open UI
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

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
