" Mappings
map <leader>= :ALEFix<cr>
nmap <silent> [e <Plug>(ale_previous_wrap)
nmap <silent> ]e <Plug>(ale_next_wrap)

" Configs
let g:ale_ruby_rubocop_executable = 'bundle'

let b:ale_linters = {
  \ 'python': ['pylint'],
  \ 'ruby': ['rubocop'],
  \}

let g:ale_fixers = {
  \ '*': ['remove_trailing_lines', 'trim_whitespace'],
  \ 'python': ['black'],
  \ 'ruby': ['rubocop'],
  \}
