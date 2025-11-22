require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    ruby = { "rubocop" },
    markdown = { "prettier" },
    -- javascript = { "prettierd", "prettier", stop_after_first = true },
  },
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
