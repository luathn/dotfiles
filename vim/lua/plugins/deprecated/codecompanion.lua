local fmt = string.format

local constants = {
  LLM_ROLE = "llm",
  USER_ROLE = "user",
  SYSTEM_ROLE = "system",
}

return {
  strategies = {
    chat = {
      adapter = "anthropic",
    },
    inline = {
      adapter = "anthropic",
    },
  },
  prompt_library = {
    ["Gen Commit Message"] = {
      strategy = "inline",
      opts = {
        placement = "replace"
      },
      prompts = {
        {
          role = "user",
          content = function()
            return "Follow the commitizen convention. The title must have a maximum of 50 characters. "
              .. "Provide only the commit title without any additional text, explanation, or formatting. "
              .. "Do not include a commit body or any other information."
              .. "\n\n```\n"
              .. vim.fn.system("git diff --staged")
              .. "\n```"
          end,
          opts = {
            contains_code = true,
          },
        },
      },
    },
    ["Correct my English"] = {
      strategy = "inline",
      description = "Correct my English",
      opts = {
        placement = "replace",
        -- modes = { "v" },
      },
      prompts = {
        {
          role = constants.SYSTEM_ROLE,
          content = [[When asked to correct my English, follow these steps:
1. Identify the programming language.
2. Identify the context. It is text in test file or in comment or ...
]],
          opts = {
            visible = false,
          },
        },
        {
          role = constants.USER_ROLE,
          content = function(context)
            local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

            return fmt(
              [[Please correct my English and replace my code:
%s
%s
]],
              context.filetype,
              code
            )
          end,
          opts = {
            contains_code = true,
          },
        },
      },
    },
    ["Translate my translations"] = {
      strategy = "chat",
      description = "Translate my translations",
      opts = {
        default_prompt = true,
        modes = { "v" },
        short_name = "translate_translation",
        auto_submit = true,
        stop_context_insertion = true,
      },
      prompts = {
        {
          role = constants.SYSTEM_ROLE,
          content = [[When asked to Translate my translations, follow these steps:
1. Identify the translation key
2. Translate content to vi and ha, do not translate key
]],
          opts = {
            visible = false,
          },
        },
        {
          role = constants.USER_ROLE,
          content = function(context)
            local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

            return fmt(
              [[Please translate my translations:
%s
%s
]],
              context.filetype,
              code
            )
          end,
          opts = {
            contains_code = true,
          },
        },
      },
    },
    ["Generate rspec"] = {
      strategy = "chat",
      description = "Generate Rspec for Rails code",
      opts = {
        default_prompt = true,
        -- modes = { "v" },
        short_name = "translate_translation",
        auto_submit = true,
        stop_context_insertion = true,
      },
      prompts = {
        {
          role = constants.SYSTEM_ROLE,
          content = function(context)
            return "Please consider the following when generating the RSpec tests:\n"
              .. "- Use shoulda-matchers gem to test validations"
              .. "- Use FactoryBot for creating test data. Just use create(:name)\n"
              .. "- Don't use let or before hook\n"
              .. "- Test each scope in each different describe\n"
          end,
          opts = {
            visible = false,
          },
        },
        {
          role = constants.USER_ROLE,
          content = function(context)
            local code = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

            return "I'm working on a Rails application and need help writing RSpec tests.\n"
              .. "Please generate RSpec code for the following:\n\n```" .. context.filetype .. "\n" .. code .. "\n```\n"
          end,
          opts = {
            contains_code = true,
          },
        },
      },
    },
  },
  display = {
    diff = {
      enabled = true,
      -- close_chat_at = 240, -- Close an open chat buffer if the total columns of your display are less than...
      -- layout = "vertical", -- vertical|horizontal split for default provider
      -- opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
      -- -- provider = "mi", -- default|mini_diff
    },
  }
}
