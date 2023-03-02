local M = {}

M.nmap = function(shortcut, command, opts)
  vim.keymap.set("n", shortcut, command, opts)
end

return M
