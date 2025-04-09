require("gp").setup({
  hooks = {
    -- example of adding command which writes unit tests for the selected code
    UnitTests = function(gp, params)
      local template = "I have the following code from {{filename}}:\n\n"
      .. "```{{filetype}}\n{{selection}}\n```\n\n"
      .. "Please respond by writing table driven unit tests for the code above."
      local agent = gp.get_command_agent()
      gp.Prompt(params, gp.Target.enew, agent, template)
    end,
    Commit = function(gp, params)
      -- Get the staged diff using a shell command
      local handle = io.popen("git diff --staged")
      local staged_code_diff = handle:read("*a")
      handle:close()
      staged_code_diff = staged_code_diff:gsub("`", "\\`")

      local template = "Generate only the commit title for the following staged changes:\n"
      .. "```\n"
      .. staged_code_diff
      .. "```\n"
      .. "Follow the commitizen convention. The title must have a maximum of 50 characters. "
      .. "Provide only the commit title without any additional text, explanation, or formatting. "
      .. "Do not include a commit body or any other information."

      local agent = gp.get_command_agent()
      gp.Prompt(params, gp.Target.prepend, agent, template)
    end,
    Correct = function(gp, params)
      local template = "I have the following code from {{filename}}:\n\n"
      .. "```{{filetype}}\n{{selection}}\n```\n\n"
      .. "Please respond by correct my English in that code"
      .. "Do not include any other code or any other information."

      local agent = gp.get_command_agent()
      gp.Prompt(params, gp.Target.rewrite, agent, template)
    end,
  },
  providers = {
    openai = {
      disable = true,
      endpoint = "https://api.openai.com/v1/chat/completions",
      -- secret = os.getenv("OPENAI_API_KEY"),
    },
    copilot = {
      disable = true,
      endpoint = "https://api.githubcopilot.com/chat/completions",
      secret = {
        "bash",
        "-c",
        "cat ~/.config/github-copilot/hosts.json | sed -e 's/.*oauth_token...//;s/\".*//'",
      },
    },
    ollama = {
      disable = true,
      endpoint = "http://localhost:11434/v1/chat/completions",
      secret = "dummy_secret",
    },
    anthropic = {
      disable = false,
      endpoint = "https://api.anthropic.com/v1/messages",
      secret = os.getenv("ANTHROPIC_API_KEY"),
    },
    googleai = {
      disable = false,
      endpoint = "https://generativelanguage.googleapis.com/v1beta/models/{{model}}:streamGenerateContent?key={{secret}}",
      secret = os.getenv("GEMINI_API_KEY"),
    },
  },
  default_chat_agent = "ChatGemini-2.0-flash",
  default_command_agent = "ChatGemini-2.0-flash",
  agents = {
    {
      provider = "anthropic",
      name = "ChatClaude-3-7-Sonnet",
      chat = true,
      command = true,
      -- string with model name or table with model name and parameters
      model = { model = "claude-3-7-sonnet-latest", temperature = 0.8, top_p = 1 },
      -- system prompt (use this to specify the persona/role of the AI)
      system_prompt = require("gp.defaults").chat_system_prompt,
    },
    {
      provider = "googleai",
      name = "ChatGemini-2.0-flash",
      chat = true,
      command = false,
      -- string with model name or table with model name and parameters
      model = { model = "gemini-2.0-flash", temperature = 1.1, top_p = 1 },
      -- system prompt (use this to specify the persona/role of the AI)
      system_prompt = require("gp.defaults").chat_system_prompt,
    },
    {
      provider = "googleai",
      name = "ChatGemini-2.5-pro-exp",
      chat = true,
      command = false,
      -- string with model name or table with model name and parameters
      model = { model = "gemini-2.5-pro-exp-03-25", temperature = 1.1, top_p = 1 },
      -- system prompt (use this to specify the persona/role of the AI)
      system_prompt = require("gp.defaults").chat_system_prompt,
    },
  },
})
