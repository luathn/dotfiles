local dap = require("dap")

dap.adapters.ruby = function(callback, config)
  if config.request == "attach" then
    callback {
      type = "pipe",
      pipe = '/tmp/ruby-debug.sock',
      -- host = "127.0.0.1",
      -- port = "9797",
    }
  else
    callback {
      type = "server",
      host = "127.0.0.1",
      port = "9797",
      executable = {
        command = "rdbg",
        args = { "-n", "--open", "--port", "9797",
          "-c", "--", config.command, config.script,
        },
      },
    }
  end
end

dap.configurations.ruby = {
  {
    type = 'ruby',
    name = 'Attach',
    request = 'attach',
  },
  {
    type = "ruby",
    name = "debug current file",
    request = "launch",
    localfs = true,
    command = "ruby",
    script = "${file}",
  },
}
