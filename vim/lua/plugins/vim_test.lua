-- Custom strategy if need to change the position of new term
-- function! s:neovim_new_term(cmd) abort
--   let term_position = get(g:, 'test#neovim#term_position', 'vertical')
--   execute term_position . ' new'
--   call termopen(a:cmd)
-- endfunction
--
-- function! VeTermStrategy(cmd)
--   echo 'It works! Command for running tests: ' . a:cmd
--   let l:cmd = [a:cmd, '']
--   let l:tag = '_test_vim_neovim_sticky'
--   let l:buffers = getbufinfo({ 'buflisted': 1 })
--     \ ->filter({i, v -> has_key(v.variables, l:tag)})
--
--   if len(l:buffers) == 0
--     let l:current_window = win_getid()
--     call s:neovim_new_term(&shell)
--     let b:[l:tag] = 1
--     let l:buffers = getbufinfo(bufnr())
--     call win_gotoid(l:current_window)
--   else
--     if !get(g:, 'test#preserve_screen', 1)
--       let l:cmd = [&shell == 'cmd.exe' ? 'cls': 'clear'] + l:cmd
--     endif
--     if get(g:, 'test#neovim_sticky#kill_previous', 0)
--       let l:cmd = [""] + l:cmd
--     endif
--   endif
--
--   let l:win = win_findbuf(l:buffers[0].bufnr)
--   if !len(l:win) && get(g:, 'test#neovim_sticky#reopen_window', 0)
--     let l:win = [s:neovim_reopen_term(l:buffers[0].bufnr)]
--   endif
--
--   " Needs explicit join to work in all shells
--   call chansend(l:buffers[0].variables.terminal_job_id, join(l:cmd, "\r"))
--   if len(l:win) > 0
--     call win_execute(l:win[0], 'normal G', 1)
--   endif
-- endfunction
-- let g:test#custom_strategies = {'ve_term': function('VeTermStrategy')}

vim.api.nvim_exec([[
  let g:test#strategy = 'neovim_sticky'
  let g:test#basic#start_normal = 1
]], true)
