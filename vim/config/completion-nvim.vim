" Completion Mappings
autocmd BufEnter * lua require'completion'.on_attach()
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <c-j>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <c-k> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Configs
set completeopt=menuone,noinsert,noselect
set shortmess+=c
let g:completion_chain_complete_list = [
    \{'complete_items': ['buffers', 'lsp']},
    \{'mode': '<c-p>'},
    \{'mode': '<c-n>'}
\]
let g:completion_matching_smart_case = 1
