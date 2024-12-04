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
  -- telescope_sorter = function()
  --   return require("telescope").extensions.fzf.native_fzf_sorter()
  -- end,
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
  kind = "auto",
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
    diffview = true,
    fzf_lua = true,
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
    commit_editor = {
      ["q"] = "Close",
      ["<c-c><c-c>"] = "Submit",
      ["<c-c><c-k>"] = "Abort",
    },
    commit_editor_I = {
      ["<c-c><c-c>"] = "Submit",
      ["<c-c><c-k>"] = "Abort",
    },
    rebase_editor = {
      ["p"]          = "Pick",
      ["r"]          = "Reword",
      ["e"]          = "Edit",
      ["s"]          = "Squash",
      ["f"]          = "Fixup",
      ["x"]          = "Execute",
      ["d"]          = "Drop",
      ["b"]          = "Break",
      ["q"]          = "Close",
      ["<cr>"]       = "OpenCommit",
      ["gk"]         = "MoveUp",
      ["gj"]         = "MoveDown",
      ["<c-c><c-c>"] = "Submit",
      ["<c-c><c-k>"] = "Abort",
      ["[c"]         = "OpenOrScrollUp",
      ["]c"]         = "OpenOrScrollDown",
    },
    rebase_editor_I = {
      ["<c-c><c-c>"] = "Submit",
      ["<c-c><c-k>"] = "Abort",
    },
    finder = {
      ["<cr>"]    = "Select",
      ["<c-c>"]   = "Close",
      ["<esc>"]   = "Close",
      ["<c-n>"]   = "Next",
      ["<c-p>"]   = "Previous",
      ["<down>"]  = "Next",
      ["<up>"]    = "Previous",
      ["<tab>"]   = "MultiselectToggleNext",
      ["<s-tab>"] = "MultiselectTogglePrevious",
    },
    popup = {
      ["?"] = "HelpPopup",
      ["A"] = "CherryPickPopup",
      ["B"] = "BisectPopup",
      ["b"] = "BranchPopup",
      ["c"] = "CommitPopup",
      ["d"] = "DiffPopup",
      ["f"] = "FetchPopup",
      ["i"] = "IgnorePopup",
      ["l"] = false,
      ["L"] = "LogPopup",
      ["m"] = "MergePopup",
      ["M"] = "RemotePopup",
      ["p"] = "PullPopup",
      ["P"] = "PushPopup",
      ["r"] = "RebasePopup",
      ["t"] = "TagPopup",
      ["v"] = false,
      ["T"] = "RevertPopup",
      ["w"] = false,
      ["W"] = "WorktreePopup",
      ["X"] = "ResetPopup",
      ["Z"] = "StashPopup",
    },
    status = {
      ["q"]     = "Close",
      ["I"]     = "InitRepo",
      ["1"]     = "Depth1",
      ["2"]     = "Depth2",
      ["3"]     = "Depth3",
      ["4"]     = "Depth4",
      ["<tab>"] = "Toggle",
      ["x"]     = "Discard",
      ["s"]     = "Stage",
      ["S"]     = "StageUnstaged",
      ["<c-s>"] = "StageAll",
      ["u"]     = "Unstage",
      ["U"]     = "UnstageStaged",
      ["R"]     = "ShowRefs",
      ["$"]     = "CommandHistory",
      ["Y"]     = "YankSelected",
      ["<c-r>"] = "RefreshBuffer",
      ["<cr>"]  = "GoToFile",
      ["<c-v>"] = "VSplitOpen",
      ["<c-x>"] = "SplitOpen",
      ["<c-t>"] = "TabOpen",
      ["{"]     = "GoToPreviousHunkHeader",
      ["}"]     = "GoToNextHunkHeader",
      ["[c"]    = "OpenOrScrollUp",
      ["]c"]    = "OpenOrScrollDown",
    },
  }
}
