local dap = require("dap")
local dapui = require("dapui")

vim.api.nvim_set_keymap("n", "<leader>dd", "<cmd>lua require('dap').continue()<CR>", {silent=true, noremap=true})
vim.api.nvim_set_keymap("n", "<leader>dq", "<cmd>lua require('dap').disconnect()<CR>", {silent=true, noremap=true})
vim.api.nvim_set_keymap("n", "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<CR>", {silent=true, noremap=true})
vim.api.nvim_set_keymap("n", "<leader>dB", "<cmd>lua require('dap').set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>", {silent=true, noremap=true})
vim.api.nvim_set_keymap("n", "<leader>dB", "<cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>", {silent=true, noremap=true})
vim.api.nvim_set_keymap("n", "<leader>dr", "<cmd>lua require('dap').repl.toggle()<CR>", {silent=true, noremap=true})
vim.api.nvim_set_keymap("n", "<leader>dl", "<cmd>lua require('dap').run_last()<CR>", {silent=true, noremap=true})
vim.api.nvim_set_keymap("n", "<F5>", "<cmd>lua require('dap').continue()<CR>", {silent=true, noremap=true})
vim.api.nvim_set_keymap("n", "<F10>", "<cmd>lua require('dap').step_over()<CR>", {silent=true, noremap=true})
vim.api.nvim_set_keymap("n", "<F11>", "<cmd>lua require('dap').step_into()<CR>", {silent=true, noremap=true})
vim.api.nvim_set_keymap("n", "<S-F11>", "<cmd>lua require('dap').step_out()<CR>", {silent=true, noremap=true})

vim.api.nvim_set_keymap("n", "<leader>dt", "<cmd>lua require('dapui').toggle()<CR>", {silent=true, noremap=true})
vim.api.nvim_set_keymap("n", "<leader>de", "<cmd>lua require('dapui').eval()<CR>", {silent=true, noremap=true})
vim.api.nvim_set_keymap("v", "<leader>de", "<cmd>lua require('dapui').eval()<CR>", {silent=true, noremap=true})
vim.api.nvim_set_keymap("n", "<leader>df", "<cmd>lua require('dapui').float_element(scopes)<CR>", {silent=true, noremap=true})

-- Dap UI
dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

dapui.setup({
  icons = {
    expanded = "",
    collapsed = ""
  },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = {"<CR>", "<2-LeftMouse>", "<Tab>"},
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    close_floating = {"<Esc>", "q"},
  },
  layouts = {
    {
      elements = {
        -- You can change the order of elements in the sidebar
        "breakpoints",
        "scopes",
        -- "stacks",
        "watches",
      },
      size = 40,
      position = "left"
    },
    {
      elements = { "repl" },
      size = 9,
      position = "bottom" -- Can be "bottom" or "top"
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil,  -- Floats will be treated as percentage of your screen.
    close = { "q", "<Esc>" },
  }
})

-- Nodejs
dap.adapters.node2 = {
  type = "executable",
  command = "node",
  args = {os.getenv("HOME") .. "/.dapinstall/jsnode_dbg/vscode-node-debug2/out/src/nodeDebug.js"},
}

dap.configurations.typescript = {
  {
    name = "Attach start:debug",
    type = "node2",
    request = "attach",
    protocol = "inspector",
    hostName = "127.0.0.1",
    port = 9229,
    processId = "${command:PickProcess}",
  },
  -- {
  --   name = "Launch start:debug",
  --   type = "node2",
  --   request = "launch",
  --   -- program = "${workspaceFolder}/node_modules/@nestjs/cli/bin/nest.js",
  --   program = "${workspaceFolder}/src/main.ts",
  --   args = {"start", "--debug", "--watch"},
  --   cwd = vim.fn.getcwd(),
  --   sourceMaps = true,
  --   outFiles = {"${workspaceFolder}/dist/**/*.js"},
  --   protocol = "inspector",
  --   console = "integratedTerminal",
  -- },
}

-- -- Ruby
-- dap.adapters.ruby = {
--   type = "executable";
--   command = "bundle";
--   args = {"exec", "readapt", "stdio"};
-- }

-- dap.configurations.ruby = {
--   {
--     type = "ruby";
--     request = "launch";
--     name = "Rails";
--     program = "bundle";
--     programArgs = {"exec", "rails", "s"};
--     useBundler = true;
--   },
-- }

-- dap.defaults.fallback.external_terminal = {
--   command = "/usr/bin/alacritty";
--   args = {"-e"};
-- }
