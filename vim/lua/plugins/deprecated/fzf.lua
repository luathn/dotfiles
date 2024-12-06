vim.cmd([[
  let g:fzf_layout = { 'down': '~40%' }
  let g:fzf_preview_window = ['up,40%', 'ctrl-/']

  function! s:build_quickfix_list(lines)
    call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
    copen
    cc
  endfunction

  let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-s': 'split',
    \ 'ctrl-v': 'vsplit',
    \ 'ctrl-q': function('s:build_quickfix_list') }

  function! s:expect_keys(keys_list)
      let key_results = keys(get(g:, 'fzf_action'))
      for k in a:keys_list
          if len(k) > 0
              call add(key_results, k)
          endif
      endfor
      return "--expect=".join(key_results, ',')
  endfunction

  function! s:action_for(key, ...)
    return get(get(g:, 'fzf_action'), a:key)
  endfunction

  function! s:bufopen(lines)
    if len(a:lines) < 2
      return
    endif
    let b = matchstr(a:lines[1], '\[\zs[0-9]*\ze\]')
    if empty(a:lines[0]) && get(g:, 'fzf_buffers_jump')
      let [t, w] = s:find_open_window(b)
      if t
        call s:jump(t, w)
        return
      endif
    endif
    let cmd = s:action_for(a:lines[0])
    if !empty(cmd)
      execute 'silent' cmd
    endif
    execute 'buffer' b
  endfunction

  function! s:buffers_sink(lines, query, fullscreen)
      if len(a:lines) < 2
          return
      endif
      normal! m'
      let b = matchstr(a:lines[1], '\[\zs[0-9]*\ze\]')
      let bufname = split(a:lines[1])[-1]
      let action = a:lines[0]
      if action ==? 'ctrl-d'
          execute 'bdelete' b
          return s:fzfbuffers(a:query, a:fullscreen)
      else
          return s:bufopen(a:lines)
      endif
      normal! ^zvzz
  endfunction

  function! s:fzfbuffers(query, fullscreen)
      let close_key='ctrl-d'
      let spec = { 'sink*': {lines -> s:buffers_sink(lines, a:query, a:fullscreen)},
                  \ 'options': [
                  \   '--prompt', 'Buffers> ',
                  \   s:expect_keys([close_key]),
                  \ ],
                  \ 'placeholder': '{1}'
                  \ }
      return fzf#vim#buffers(a:query, fzf#vim#with_preview(spec), a:fullscreen)
  endfunction

  command! -bar -bang -nargs=? -complete=dir FzfBuffers call s:fzfbuffers(<q-args>, <bang>0)
]])
