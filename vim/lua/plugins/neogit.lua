local neogit = require("neogit")

neogit.setup {
  disable_signs = false,
  disable_hint = false,
  disable_context_highlighting = false,
  disable_commit_confirmation = false,
  auto_refresh = true,
  sort_branches = "-committerdate",
  disable_builtin_notifications = true,
  -- customize displayed signs
  signs = {
    -- { CLOSED, OPENED }並ﴴ 
    section = { "", "" },
    item = { "", "" },
    hunk = { "+", "-" },
  },
  integrations = {
    diffview = true
  },
  -- override/add mappings
  mappings = {
    -- modify status buffer mappings
    status = {
      -- Adds a mapping with "B" as key that does the "BranchPopup" command
      ["p"] = "",
      ["<c-s>"] = "",
      ["F"] = "PullPopup",
      ["gS"] = "StageAll"
    }
  }
}
