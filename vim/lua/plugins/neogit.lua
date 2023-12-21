local neogit = require("neogit")

neogit.setup {
  disable_signs = false,
  disable_hint = false,
  disable_context_highlighting = false,
  disable_insert_on_commit = true,
  filewatcher = {
    interval = 2000,
    enabled = true,
  },
  graph_style = "ascii",
  git_services = {
    ["github.com"] = "https://github.com/${owner}/${repository}/compare/${branch_name}?expand=1",
    ["bitbucket.org"] = "https://bitbucket.org/${owner}/${repository}/pull-requests/new?source=${branch_name}&t=1",
    ["gitlab.com"] = "https://gitlab.com/${owner}/${repository}/merge_requests/new?merge_request[source_branch]=${branch_name}",
  },
  telescope_sorter = function()
    return require("telescope").extensions.fzf.native_fzf_sorter()
  end,
  remember_settings = true,
  use_per_project_settings = true,
  auto_refresh = true,
  sort_branches = "-committerdate",
  disable_line_numbers = true,
  console_timeout = 2000,
  auto_show_console = true,
  status = {
    recent_commit_count = 15,
  },
  kind = "tab",
  ignored_settings = {},
  commit_editor = {
    kind = "split",
  },
  commit_select_view = {
    kind = "tab",
  },
  commit_view = {
    kind = "vsplit",
  },
  log_view = {
    kind = "tab",
  },
  rebase_editor = {
    kind = "split",
  },
  reflog_view = {
    kind = "tab",
  },
  merge_editor = {
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
    telescope = true,
    diffview = true
  },
  sections = {
    -- Reverting/Cherry Picking
    sequencer = {
      folded = false,
      hidden = false,
    },
    untracked = {
      folded = false,
      hidden = false,
    },
    unstaged = {
      folded = false,
      hidden = false,
    },
    staged = {
      folded = false,
      hidden = false,
    },
    stashes = {
      folded = true,
      hidden = false,
    },
    unpulled_upstream = {
      folded = true,
      hidden = false,
    },
    unmerged_upstream = {
      folded = false,
      hidden = false,
    },
    unpulled_pushRemote = {
      folded = true,
      hidden = false,
    },
    unmerged_pushRemote = {
      folded = false,
      hidden = false,
    },
    recent = {
      folded = true,
      hidden = true,
    },
    rebase = {
      folded = true,
      hidden = true,
    },
  },
  -- override/add mappings
  mappings = {
    status = {
      -- ["gS"] = "StageAll"
    }
  }
}
