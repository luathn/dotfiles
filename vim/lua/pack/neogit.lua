local neogit = require("neogit")

neogit.setup {
  disable_insert_on_commit = true,
  kind = "auto",
  commit_editor = {
    kind = "split",
  },
  signs = { section = { "", "" }, item = { "", "" }, hunk = { "+", "-" } },
  mappings = {
    popup = {
      ["l"] = false,
      ["L"] = "LogPopup",
      ["p"] = false,
      ["F"] = "PullPopup",
      ["v"] = false,
      ["T"] = "RevertPopup",
      ["w"] = false,
      ["W"] = "WorktreePopup",
    },
    status = {
      ["R"] = "ShowRefs",
    },
  },
}
