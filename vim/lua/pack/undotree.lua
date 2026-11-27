vim.cmd("packadd nvim.undotree") -- Saved at ~/.local/state/nvim/undo

vim.keymap.set("n", "<leader>u", function()
  require("undotree").open({ command = math.floor(vim.api.nvim_win_get_width(0) / 3) .. "vnew" })
end, { desc = "[U]ndotree toggle" })
