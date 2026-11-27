vim.pack.add({ "https://github.com/stevearc/oil.nvim" })

require("oil").setup({
  cleanup_delay_ms = 10000,
  lsp_file_methods = {
    timeout_ms = 2000,
    autosave_changes = false,
  },
  view_options = {
    show_hidden = true,
  },
  keymaps = {
    ["<C-v>"] = { "actions.select", opts = { vertical = true } },
    ["<C-s>"] = { "actions.select", opts = { horizontal = true } },
    ["q"] = { "actions.close", mode = "n" },
    ["<C-r>"] = "actions.refresh",
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

vim.keymap.set("n", "-", function() require("oil").open() end, { desc = "Open parent directory" })
