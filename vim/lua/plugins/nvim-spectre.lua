require("spectre").setup({
  is_block_ui_break = true,
  color_devicons = true,
  highlight = {
    headers = "Comment",
    ui = "String",
    filename = "Keyword",
    filedirectory = "Comment",
    search = "MatchParen",
    border = "Comment",
    replace = "DiffDelete"
  },
  mapping={
    ['open_in_vsplit'] = {
      map = "<c-v>",
      cmd = "<cmd>lua vim.cmd('vsplit ' .. require('spectre.actions').get_current_entry().filename)<CR>",
      desc = "open in vertical split"
    },
    ['open_in_split'] = {
      map = "<c-s>",
      cmd = "<cmd>lua vim.cmd('split ' .. require('spectre.actions').get_current_entry().filename)<CR>",
      desc = "open in horizontal split"
    },
    ['open_in_tab'] = {
      map = "<c-t>",
      cmd = "<cmd>lua vim.cmd('tab split ' .. require('spectre.actions').get_current_entry().filename)<CR>",
      desc = "open in new tab"
    },
    ['quit'] = {
      map = "q",
      cmd = "<cmd>q<cr>",
      desc = "[q]uit spectre"
    },
    ['focus_search_input'] = {
      map = "S",
      cmd = "<cmd>3<cr>A",
      desc = "focus [S]earch input"
    },
    ['focus_directory_input'] = {
      map = "D",
      cmd = "<cmd>7<cr>A",
      desc = "focus [D]irectory input"
    },
  }
})
