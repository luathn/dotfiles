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
    default = {
      'lsp', 'path', 'snippets', 'buffer', 'codecompanion',
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
        fallbacks = {},
      },
      path = {
        name = 'Path',
        module = 'blink.cmp.sources.path',
      },
      codecompanion = {
        name = "CodeCompanion",
        module = "codecompanion.providers.completion.blink",
        enabled = true,
      },
    },
  },
  completion = {
    keyword = {
      range = 'full',
    },
    list = {
      max_items = 20,
      selection = { preselect = false, auto_insert = true },
    },
  },
  signature = { enabled = true },
}
