local M = {}

M.get = function()
  return require("colors." .. vim.g.colors_name)
end

return M
