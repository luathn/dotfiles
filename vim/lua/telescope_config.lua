local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
      n = {
        ["<C-C>"] = actions.close
      },
    },
    layout_config = {
      width = 0.9,
      height = 0.7,
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = false, -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}

require('telescope').load_extension('fzf')

_G.no_preview = function()
  return require('telescope.themes').get_dropdown({
    borderchars = {
      { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
      prompt = {"─", "│", " ", "│", '┌', '┐', "│", "│"},
      results = {"─", "│", "─", "│", "├", "┤", "┘", "└"},
      preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
    },
    layout_config = {
      width = 0.9,
    },
    previewer = false,
    prompt_title = false
  })
end

vim.api.nvim_set_keymap('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<cr>", {silent=true, noremap=true})
vim.api.nvim_set_keymap('n', '<leader>fg', "<cmd>lua require('telescope.builtin').live_grep()<cr>", {silent=true, noremap=true})
vim.api.nvim_set_keymap('n', '<leader>fb', "<cmd>lua require('telescope.builtin').buffers()<cr>", {silent=true, noremap=true})

-- vim.api.nvim_set_keymap('n', '<leader>ft', '<cmd>lua require(\'telescope.builtin\').find_files(no_preview())<cr>', {silent=true, noremap=true})
-- nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags(no_preview())<cr>
