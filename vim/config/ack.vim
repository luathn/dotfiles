" Mappings
nnoremap <leader>a :Ack!<Space>
" When you press gv you Ack after the selected text
vnoremap <leader>a :call VisualSelection('gv', '')<CR>

" Configs
let g:ackprg = "rg --vimgrep --type-not sql --smart-case"
let g:ack_mappings = {
  \ 'h': '<C-W>k<C-W>l<C-W>l<C-W>s<C-W>j<CR>',
  \ 'v': '<C-W><CR><C-W>L<C-W>p<C-W>J<C-W>p',
  \ 'gv': '<C-W><CR><C-W>L<C-W>p<C-W>J',
  \ 'q': '<C-W>p' }
