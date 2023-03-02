navic = require("nvim-navic")
ui_winbar = require("ui.winbar")

navic.setup {
  lsp = {
      auto_attach = false,
      preference = nil,
  },
  highlight = false,
  separator = "  ",
  depth_limit = 0,
  depth_limit_indicator = "..",
  safe_output = true
}

local excludes = function()
  if vim.tbl_contains(ui_winbar.winbar_filetype_exclude, vim.bo.filetype) then
    vim.opt_local.winbar = nil
    return true
  end
  return false
end

vim.api.nvim_create_autocmd(
  { "BufWinEnter" },
  {
    callback = function()
      if excludes() then
        return
      end
      vim.opt_local.winbar = "%{%v:lua.ui_winbar.eval()%}"
    end,
  }
)
