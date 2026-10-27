-- Return the names of terminal buffers whose job is still running
local function running_term_jobs()
  local jobs = {}
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buftype == "terminal" then
      local chan = vim.bo[buf].channel
      -- jobwait with a 0 timeout returns -1 if the job is still running
      if chan > 0 and vim.fn.jobwait({ chan }, 0)[1] == -1 then
        table.insert(jobs, vim.api.nvim_buf_get_name(buf))
      end
    end
  end
  return jobs
end

-- Returns true if quitting is allowed
local function confirm_quit()
  local jobs = running_term_jobs()
  if #jobs == 0 then
    return true
  end
  local msg = ("%d terminal job(s) still running:\n%s\n\nQuit anyway?")
    :format(#jobs, table.concat(jobs, "\n"))
  return vim.fn.confirm(msg, "&Yes\n&No", 2) == 1
end

-- orig:       the original command typed in the cmdline
-- wrapper:    the replacement user command (must start with an uppercase letter)
-- real:       the actual Ex command to run after confirmation
-- closes_all: true if the command exits all of nvim (always asks);
--             false if it only closes the current window (asks only when it is the last window)
local defs = {
  { orig = "q",   wrapper = "Q",   real = "quit",  closes_all = false },
  { orig = "qa",  wrapper = "Qa",  real = "qall",  closes_all = true },
  { orig = "wq",  wrapper = "Wq",  real = "wq",    closes_all = false },
  { orig = "wqa", wrapper = "Wqa", real = "wqall", closes_all = true },
  { orig = "x",   wrapper = "X",   real = "xit",   closes_all = false },
  { orig = "xa",  wrapper = "Xa",  real = "xall",  closes_all = true },
}

for _, d in ipairs(defs) do
  vim.api.nvim_create_user_command(d.wrapper, function(opts)
    local is_last_window = #vim.api.nvim_list_wins() == 1
    local needs_check = d.closes_all or is_last_window

    if needs_check and not confirm_quit() then
      return
    end

    -- Rebuild the real command, preserving the bang and any arguments (e.g. file name)
    local cmd = d.real .. (opts.bang and "!" or "")
    if opts.args ~= "" then
      cmd = cmd .. " " .. opts.args
    end
    vim.cmd(cmd)
  end, { bang = true, nargs = "*", complete = "file" })

  -- Replace the command only when it is the first word of the cmdline,
  -- so things like ":help q" or ":s/a/q" are left untouched
  vim.cmd(([[cnoreabbrev <expr> %s getcmdtype() == ":" && getcmdline() == "%s" ? "%s" : "%s"]])
    :format(d.orig, d.orig, d.wrapper, d.orig))
end

-- Quick-quit keymaps bypass the cmdline, so the abbreviations cannot catch them;
-- map them explicitly to the safe wrappers
vim.keymap.set("n", "ZZ", "<cmd>X<cr>", { desc = "Save and quit (safe)" })
vim.keymap.set("n", "ZQ", "<cmd>Q!<cr>", { desc = "Quit without saving (safe)" })
