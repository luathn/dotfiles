return {
  panel = {
    enabled = true,
    auto_refresh = false,
    keymap = {
      jump_prev = "[[",
      jump_next = "]]",
      accept = "<CR>",
      refresh = "gr",
      open = "<M-CR>"
    },
    layout = {
      position = "bottom", -- | top | left | right
      ratio = 0.4
    },
  },
  -- suggestion = {
  --   enabled = true,
  --   auto_trigger = false,
  --   hide_during_completion = true,
  --   debounce = 75,
  --   keymap = {
  --     accept = "<tab>",
  --     accept_word = false,
  --     accept_line = false,
  --     next = "<c-n>",
  --     prev = "<c-p>",
  --     dismiss = "<C-]>",
  --   },
  -- },
  filetypes = {
    yaml = false,
    markdown = false,
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    json = false,
    ["."] = false,
  },
  copilot_node_command = 'node', -- Node.js version must be > 18.x
  server_opts_overrides = {},
}
