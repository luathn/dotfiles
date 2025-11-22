require("mini.indentscope").setup({
  draw = {
    delay = 0,
    animation = require("mini.indentscope").gen_animation.none(),
  },
})

local disabled_filetypes = { terminal = true, snacks_terminal = true }
local disable_in_ft = function(opts)
  local ft = vim.bo[opts.buf].filetype
  if disabled_filetypes[ft] then vim.b[opts.buf].miniindentscope_disable = true end
end
local augroup = vim.api.nvim_create_augroup('MiniIndentScopeDisable', { clear = true })
vim.api.nvim_create_autocmd('FileType', { group = augroup, callback = disable_in_ft })
