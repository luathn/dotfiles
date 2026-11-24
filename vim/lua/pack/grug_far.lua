require('grug-far').setup({
  minSearchChars = 3,
  prefills = {
    flags = '-i',
  },
  keymaps = {
    close = { n = 'q' },
    abort = { n = '<c-g>' },
    historyOpen = { n = '<localleader>h' },
  },
})
