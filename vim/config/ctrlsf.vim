" Mappings
let g:ctrlsf_mapping = {
  \ "openb": { "key": "O", "suffix": "<C-w>p" },
  \ "vsplit": "v",
  \ }
nmap     <C-F>f <Plug>CtrlSFPrompt
vmap     <C-F>f <Plug>CtrlSFVwordPath
vmap     <C-F>F <Plug>CtrlSFVwordExec
nmap     <C-F>n <Plug>CtrlSFCwordPath
nmap     <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>

" Configs
let g:ctrlsf_backend = 'rg'
let g:ctrlsf_extra_backend_args = {
    \ 'rg': '--vimgrep --type-not sql --smart-case'
    \ }
let g:ctrlsf_default_view_mode = 'compact'
let g:ctrlsf_auto_focus = {
  \ "at": "start"
  \ }
