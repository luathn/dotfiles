require("oil").setup({
  cleanup_delay_ms = 10000,
  lsp_file_methods = {
    timeout_ms = 2000,
    autosave_changes = false,
  },
  use_default_keymaps = false,
  view_options = {
    show_hidden = true,
  },
  keymaps = {
    ["g?"] = "actions.show_help",
    ["<CR>"] = "actions.select",
    ["<C-v>"] = { "actions.select", opts = { vertical = true } },
    ["<C-s>"] = { "actions.select", opts = { horizontal = true } },
    ["<C-t>"] = { "actions.select", opts = { tab = true } },
    ["<C-p>"] = "actions.preview",
    ["<C-c>"] = { "actions.close", mode = "n" },
    ["q"] = "actions.close",
    ["<C-r>"] = "actions.refresh",
    ["-"] = "actions.parent",
    ["_"] = "actions.open_cwd",
    ["gcd"] = "actions.cd",
    ["~"] = "actions.tcd",
    ["gs"] = "actions.change_sort",
    ["gx"] = "actions.open_external",
    ["g."] = "actions.toggle_hidden",
    ["g\\"] = "actions.toggle_trash",
    ["<leader>ss"] = {
      callback = function()
        local dir = require("oil").get_current_dir()
        local prefills = { paths = vim.fn.fnamemodify(dir, ":~:.") }

        local grug_far = require "grug-far"
        if not grug_far.has_instance "explorer" then
          grug_far.open {
            instanceName = "explorer",
            prefills = prefills,
            staticTitle = "Find and Replace from Explorer",
          }
        else
          grug_far.open_instance "explorer"
          grug_far.update_instance_prefills("explorer", prefills, false)
        end
      end,
      desc = "oil: Search in directory",
    },
  },
})
