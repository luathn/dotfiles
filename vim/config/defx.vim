" Mappings
nnoremap <C-n> :Defx -winwidth=30<CR>
nnoremap <silent> <leader>ff :Defx -winwidth=30 -toggle=0 -search=`expand('%:p')`<CR>

autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
  " Define mappings
  nnoremap <nowait><silent><buffer><expr> c
  \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> x
  \ defx#do_action('move')
  nnoremap <nowait><silent><buffer><expr> d
  \ defx#do_action('remove')
  nnoremap <silent><buffer><expr> p
  \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> r
  \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> m
  \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> gm
  \ defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> <CR>
  \ defx#is_directory() ?
  \ defx#do_action('open_or_close_tree') :
  \ defx#do_action('drop')
  nnoremap <silent><buffer><expr> o
  \ defx#is_directory() ?
  \ defx#do_action('open_or_close_tree') :
  \ defx#do_action('drop')
  nnoremap <silent><buffer><expr> <2-LeftMouse>
  \ defx#is_directory() ?
  \ defx#do_action('open_or_close_tree') :
  \ defx#do_action('drop')
  nnoremap <silent><buffer><expr> i
  \ defx#do_action('close_tree')
  nnoremap <silent><buffer><expr> l
  \ defx#do_action('open_directory')
  nnoremap <silent><buffer><expr> h
  \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> v
  \ defx#do_action('toggle_select')
  nnoremap <silent><buffer><expr> V
  \ defx#do_action('clear_select_all')
  nnoremap <silent><buffer><expr> *
  \ defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> E
  \ defx#do_action('open', 'vsplit')
  nnoremap <silent><buffer><expr> P
  \ defx#do_action('preview')
  nnoremap <silent><buffer><expr> M
  \ defx#do_action('multi', [
  \ ['resize', ToggleDefxWidth(defx#get_context().winwidth)],
  \ ['toggle_columns', 'mark:indent:icon:filename:type:size:time']
  \ ])
  nnoremap <silent><buffer><expr> S
  \ defx#do_action('toggle_sort', 'time')
  nnoremap <silent><buffer><expr> s
  \ defx#do_action('search')
  nnoremap <silent><buffer><expr> !
  \ defx#do_action('execute_command')
  nnoremap <silent><buffer><expr> X
  \ defx#do_action('execute_system')
  nnoremap <nowait><silent><buffer><expr> y
  \ defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> H
  \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> ;
  \ defx#do_action('repeat')
  nnoremap <silent><buffer><expr> ~
  \ defx#do_action('cd')
  nnoremap <silent><buffer><expr> q
  \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> j
  \ line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k
  \ line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> <C-r>
  \ defx#do_action('redraw')
  nnoremap <silent><buffer><expr> <C-g>
  \ defx#do_action('print')
  nnoremap <silent><buffer><expr> cd
  \ defx#do_action('change_vim_cwd')
endfunction

" Configs
call defx#custom#option('_', {
  \ 'split': 'vertical',
  \ 'direction': 'topleft',
  \ 'show_ignored_files': 0,
  \ 'resume': 1,
  \ 'toggle': 1,
  \ 'columns': 'mark:indent:icon:filename',
  \ })

call defx#custom#column('icon', {
  \ 'directory_icon': '',
  \ 'opened_icon': 'ﱮ',
  \ })

call defx#custom#column('mark', {
  \ 'readonly_icon': '',
  \ 'selected_icon': '',
  \ })

function! ToggleDefxWidth(winwidth)
  if a:winwidth == '30'
    return 80
  endif
  return 30
endfunction
