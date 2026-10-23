-- Generate a commit title for the staged changes with the `llm` CLI and insert
-- it at the top of the current buffer (e.g. the Neogit commit message buffer).
local M = {}

local model = "gemini-2.5-flash-lite"

local prompt = "Generate only the commit title for the staged changes above. "
  .. "Follow the commitizen convention. The title must have a maximum of 50 characters. "
  .. "Provide only the commit title without any additional text, explanation, or formatting. "
  .. "Do not include a commit body or any other information."

function M.generate()
  local diff = vim.fn.system({ "git", "diff", "--staged" })
  if vim.v.shell_error ~= 0 or diff == "" then
    vim.notify("No staged changes", vim.log.levels.WARN)
    return
  end

  local buf = vim.api.nvim_get_current_buf()

  vim.notify("Generating commit message...")
  vim.system(
    { "llm", "-m", model, "-o", "temperature", "1.1", "--no-log", prompt },
    { stdin = diff, text = true },
    vim.schedule_wrap(function(res)
      if res.code ~= 0 then
        vim.notify("llm failed: " .. (res.stderr or ""), vim.log.levels.ERROR)
        return
      end
      if not vim.api.nvim_buf_is_valid(buf) then return end
      local text = vim.trim(res.stdout):gsub("^`+", ""):gsub("`+$", "")
      vim.api.nvim_buf_set_lines(buf, 0, 0, false, vim.split(text, "\n"))
    end)
  )
end

vim.api.nvim_create_user_command("AiCommit", M.generate, { desc = "Generate commit title from staged diff" })

return M
