" Fern Mappings
nnoremap <C-n> :Fern . -drawer -toggle<CR>
nnoremap <silent> <Leader>ff :Fern . -drawer -reveal=%<CR>

function! s:init_fern() abort
  nmap <nowait><buffer> d <Plug>(fern-action-remove)
  nmap <nowait><buffer> c <Plug>(fern-action-clipboard-copy)
  nmap <buffer> x <Plug>(fern-action-clipboard-move)
  nmap <buffer> p <Plug>(fern-action-clipboard-paste)
  nmap <buffer> o <Plug>(fern-action-open-or-expand)
  nmap <buffer> i <Plug>(fern-action-collapse)
  nmap <buffer> l <Plug>(fern-action-open-or-enter)
  nmap <buffer> h <Plug>(fern-action-leave)
  nmap <buffer> m <Plug>(fern-action-new-path)
  nmap <buffer> v <Plug>(fern-action-mark:toggle)
  nmap <buffer> V <Plug>(fern-action-mark:clear)
  nmap <buffer> r <Plug>(fern-action-rename)
  nmap <buffer> H <Plug>(fern-action-hidden:toggle)
  nmap <buffer> fi <Plug>(fern-action-include)
  nmap <buffer> z <Plug>(fern-action-zoom)
  nmap <buffer> <C-R> <Plug>(fern-action-reload)
  nmap <buffer> <CR> <Plug>(fern-action-open-or-expand)
  nmap <buffer> <C-C> <Plug>(fern-action-cancel)
  nmap <buffer> q :<C-u>quit<CR>
endfunction

" Configs
let g:fern#disable_default_mappings = 1
let g:fern#disable_viewer_spinner = 1
let g:fern#renderer#default#root_symbol = '[root] '
let g:fern#renderer#default#leading = '  '
let g:fern#renderer#default#leaf_symbol = '  '
let g:fern#renderer#default#collapsed_symbol = ' '
let g:fern#renderer#default#expanded_symbol = 'ﱮ '

function! s:on_highlight() abort
  highlight link FernRootSymbol Comment
  highlight link FernRootText   Statement
endfunction

augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END

augroup my-fern-highlight
  autocmd!
  autocmd User FernHighlight call s:on_highlight()
augroup END
