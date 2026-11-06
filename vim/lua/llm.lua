-- Small OpenRouter client, and a command that generates a commit title from the
-- staged changes and inserts it at the top of the current buffer (e.g. the
-- Neogit commit message buffer).
local M = {}

local url = "https://openrouter.ai/api/v1/chat/completions"
local default_model = "qwen/qwen3.7-flash"
local timeout_seconds = "10"

local commit_prompt = "You write git commit titles. Given a diff, reply with one "
  .. "commitizen-style title of at most 50 characters. "
  .. "Output only the title, with no explanation, quotes or formatting."

-- Send `messages` to the LLM and call `on_done(text)` on the main loop with the reply.
-- `opts` are extra API parameters (e.g. model, temperature). Errors are notified,
-- and `on_done` is not called.
function M.call(messages, opts, on_done)
  if not vim.env.OPENROUTER_API_KEY then
    vim.notify("OPENROUTER_API_KEY is not set", vim.log.levels.ERROR)
    return
  end

  local body = vim.json.encode(vim.tbl_extend("force", {
    model = default_model,
    messages = messages,
  }, opts or {}))

  vim.system({
    "curl", "-sS", url,
    "--max-time", timeout_seconds,
    "-H", "Content-Type: application/json",
    -- Read the key from the environment to keep it out of the process list
    "--variable", "%OPENROUTER_API_KEY",
    "--expand-header", "Authorization: Bearer {{OPENROUTER_API_KEY}}",
    "--data-binary", "@-",
  }, { stdin = body, text = true }, vim.schedule_wrap(function(res)
    if res.code ~= 0 then
      vim.notify("Request failed: " .. (res.stderr or ""), vim.log.levels.ERROR)
      return
    end

    local ok, data = pcall(vim.json.decode, res.stdout, { luanil = { object = true } })
    local content = ok and data.choices and data.choices[1].message.content
    if not content then
      local reason = ok and data.error and data.error.message or res.stdout
      vim.notify("OpenRouter error: " .. reason, vim.log.levels.ERROR)
      return
    end

    on_done(content)
  end))
end

function M.generate()
  local diff = vim.fn.system({ "git", "diff", "--staged" })
  if vim.v.shell_error ~= 0 or diff == "" then
    vim.notify("No staged changes", vim.log.levels.WARN)
    return
  end

  local buf = vim.api.nvim_get_current_buf()
  local messages = {
    { role = "system", content = commit_prompt },
    { role = "user", content = diff },
  }
  local opts = { temperature = 0.5, max_tokens = 40, reasoning = { enabled = false } }

  vim.notify("Generating commit message...")
  M.call(messages, opts, function(content)
    if not vim.api.nvim_buf_is_valid(buf) then return end
    local text = vim.trim(content):gsub("^`+", ""):gsub("`+$", "")
    vim.api.nvim_buf_set_lines(buf, 0, 0, false, vim.split(text, "\n"))
  end)
end

vim.api.nvim_create_user_command("AiCommit", M.generate, { desc = "Generate commit title from staged diff" })

return M
