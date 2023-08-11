local neogit = require("neogit")

neogit.setup {
  disable_signs = false,
  disable_hint = false,
  disable_context_highlighting = false,
  disable_commit_confirmation = false,
  auto_refresh = true,
  sort_branches = "-committerdate",
  disable_builtin_notifications = false,
  telescope_sorter = function()
    return require("telescope").extensions.fzf.native_fzf_sorter()
  end,
  use_magit_keybindings = true,
  kind = "tab",
  console_timeout = 2000,
  auto_show_console = true,
  remember_settings = true,
  use_per_project_settings = true,
  ignored_settings = {},
  commit_popup = {
    kind = "split",
  },
  preview_buffer = {
    kind = "split",
  },
  popup = {
    kind = "split",
  },
  -- customize displayed signs
  signs = {
    section = { "", "" },
    item = { "", "" },
    hunk = { "+", "-" },
  },
  integrations = {
    telescope = nil,
    diffview = true
  },
  sections = {
    untracked = {
      folded = false
    },
    unstaged = {
      folded = false
    },
    staged = {
      folded = false
    },
    stashes = {
      folded = true
    },
    unpulled = {
      folded = true
    },
    unmerged = {
      folded = true
    },
    recent = {
      folded = true
    },
  },
  -- override/add mappings
  mappings = {
    status = {
      -- ["gS"] = "StageAll"
    }
  }
}
