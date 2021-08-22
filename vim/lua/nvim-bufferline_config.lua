-- Mappings
vim.api.nvim_set_keymap('n', '<leader>l', ':BufferLineCycleNext<CR>', {silent=true, noremap=true})
vim.api.nvim_set_keymap('n', '<leader>h', ':BufferLineCyclePrev<CR>', {silent=true, noremap=true})
vim.api.nvim_set_keymap('n', '<leader>bl', ':BufferLineMoveNext<CR>', {silent=true, noremap=true})
vim.api.nvim_set_keymap('n', '<leader>bh', ':BufferLineMovePrev<CR>', {silent=true, noremap=true})

-- Configs
require'bufferline'.setup {
  options = {
    view = "multiwindow",
    numbers = "none",
    number_style = "none",
    mappings = false,
    buffer_close_icon= '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    max_name_length = 30,
    max_prefix_length = 10, -- prefix used when a buffer is deduplicated
    tab_size = 18,
    diagnostics = false,
    diagnostics_indicator = function(count, level, diagnostics_dict)
      return "("..count..")"
    end,
    -- NOTE: this will be called a lot so don't do any heavy processing here
    custom_filter = function(buf_number)
      -- filter out filetypes you don't want to see
      if vim.bo[buf_number].filetype ~= "NeogitStatus" then
        return true
      end
      -- filter out by buffer name
      if vim.fn.bufname(buf_number) ~= "NeogitStatus" then
        return true
      end
      -- filter out based on arbitrary rules
      -- e.g. filter out vim wiki buffer from tabline in your work repo
      if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
        return true
      end
    end,
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    separator_style = 'thin',
    enforce_regular_tabs = false,
    always_show_bufferline = true,
    sort_by = 'extension',
  },
  highlights = {
    fill = {
      guibg = 'NONE',
    },
    tab_close = {
      guibg = 'NONE'
    },
  }
}
