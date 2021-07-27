local saga = require 'lspsaga'

-- use_saga_diagnostic_sign = true
-- dianostic_header_icon = '   ',
-- code_action_icon = ' ',
-- code_action_prompt = {
--   enable = true,
--   sign = true,
--   sign_priority = 20,
--   virtual_text = true,
-- },
-- finder_definition_icon = '  ',
-- finder_reference_icon = '  ',
-- max_preview_lines = 10, -- preview lines of lsp_finder and definition preview
-- finder_action_keys = {
--   open = 'o', vsplit = 's',split = 'i',quit = 'q',scroll_down = '<C-f>', scroll_up = '<C-b>' -- quit can be a table
-- },
-- code_action_keys = {
--   quit = 'q',exec = '<CR>'
-- },
-- rename_action_keys = {
--   quit = '<C-c>',exec = '<CR>'  -- quit can be a table
-- },
-- definition_preview_icon = '  '
-- "single" "double" "round" "plus"
-- border_style = "single"
-- rename_prompt_prefix = '➤',
-- if you don't use nvim-lspconfig you must pass your server name and
-- the related filetypes into this table
-- like server_filetype_map = {metals = {'sbt', 'scala'}}
-- server_filetype_map = {}

saga.init_lsp_saga {
  error_sign = 'E',
  warn_sign = 'W',
  hint_sign = 'H',
  infor_sign = 'I',
}

-- vim.api.nvim_set_keymap('n', '<leader>ca', '<cmd>lua require('lspsaga.codeaction').code_action()', {silent=true, noremap=true})
vim.api.nvim_set_keymap('n', '<leader>ca', ':Lspsaga code_action<CR>', {silent=true, noremap=true})
vim.api.nvim_set_keymap('v', '<leader>ca', ':<C-U>Lspsaga range_code_action<CR>', {silent=true, noremap=true})
-- nnoremap <silent><leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>
-- vnoremap <silent><leader>ca :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>
