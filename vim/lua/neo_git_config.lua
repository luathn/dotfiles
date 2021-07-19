vim.api.nvim_set_keymap('n', '<leader>gg', ':Neogit<CR>', {silent=true, noremap=true})
vim.api.nvim_set_keymap('n', '<leader>gl', ':Neogit log<CR>', {silent=true, noremap=true})

local neogit = require("neogit")

neogit.setup {
  disable_signs = false,
  disable_context_highlighting = false,
  disable_commit_confirmation = false,
  -- customize displayed signs
  signs = {
    -- { CLOSED, OPENED }
    section = { ">", "v" },
    item = { ">", "v" },
    hunk = { "", "" },
  },
  integrations = {
    diffview = true
  },
  -- override/add mappings
  mappings = {
    -- modify status buffer mappings
    status = {
      -- Adds a mapping with "B" as key that does the "BranchPopup" command
      ["B"] = "BranchPopup",
      ["R"] = "RefreshBuffer",
    }
  }
}
