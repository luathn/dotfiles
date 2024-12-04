vim.api.nvim_exec([[
  let test#strategy = "neovim_sticky"
  let g:test#basic#start_normal = 1
]], true)
