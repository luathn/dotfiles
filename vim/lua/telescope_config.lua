local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close
      },
    },
  }
}

_G.no_preview = function()
  return require('telescope.themes').get_dropdown({
    borderchars = {
      { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
      prompt = {"─", "│", " ", "│", '┌', '┐', "│", "│"},
      results = {"─", "│", "─", "│", "├", "┤", "┘", "└"},
      preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
    },
    layout_config = {
      width = 0.8,
    },
    previewer = false,
    prompt_title = false
  })
end

vim.api.nvim_set_keymap('n', '<leader>ft', '<cmd>lua require(\'telescope.builtin\').find_files(no_preview())<cr>', {silent=true, noremap=true})

-- nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files(no_preview())<cr>
-- nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep(no_preview())<cr>
-- nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers(no_preview())<cr>
-- nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags(no_preview())<cr>
