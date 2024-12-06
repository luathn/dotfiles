return {
  keymap = { preset = 'enter' },
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
  },
  signature = { enabled = true },
}
