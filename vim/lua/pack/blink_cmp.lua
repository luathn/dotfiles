require("blink.cmp").setup({
  keymap = {
    preset = 'enter',
    ['<Tab>'] = {
      function(cmp)
        if require('blink.cmp.completion.windows.menu').win:is_open() then
          return cmp.select_next()
        end
      end,
      'snippet_forward',
      'fallback'
    },
    ['<S-Tab>'] = {
      function(cmp)
        if require('blink.cmp.completion.windows.menu').win:is_open() then
          return cmp.select_prev()
        end
      end,
      'snippet_backward',
      'fallback'
    },
  },
  sources = {
    default = { 'lsp', 'path', 'buffer' },
    providers = {
      lsp = { min_keyword_length = 2, fallbacks = {} },
    },
  },
  completion = {
    menu = { auto_show_delay_ms = 350 },
    keyword = { range = 'full' },
    list = { max_items = 20, selection = { preselect = false } },
  },
  signature = { enabled = true },
  fuzzy = { implementation = 'lua' },
})
