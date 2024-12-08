return {
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
    completion = {
      enabled_providers = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    providers = {
      lsp = {
        name = 'LSP',
        module = 'blink.cmp.sources.lsp',
        min_keyword_length = 2,
      },
      buffer = {
        name = 'Buffer',
        module = 'blink.cmp.sources.buffer',
        fallback_for = {},
      },
      path = {
        name = 'Path',
        module = 'blink.cmp.sources.path',
      },
    },
  },
  completion = {
    keyword = {
      range = 'full',
    },
    list = {
      -- Maximum number of items to display
      max_items = 20,
      selection = 'auto_insert',
    },
  },
  signature = { enabled = true },
}
