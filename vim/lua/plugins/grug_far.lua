require('grug-far').setup({
  minSearchChars = 4,
  prefills = {
    flags = '-i',
  },
  keymaps = {
    replace = { n = '<localleader>r' },
    qflist = { n = '<localleader>q' },
    syncLocations = { n = '<localleader>s' },
    syncLine = { n = '<localleader>l' },
    close = { n = 'q' },
    historyOpen = { n = '<localleader>h' },
    historyAdd = { n = '<localleader>a' },
    refresh = { n = '<localleader>f' },
    openLocation = { n = '<localleader>o' },
    openNextLocation = { n = '<c-n>' },
    openPrevLocation = { n = '<c-p>' },
    gotoLocation = { n = '<enter>' },
    pickHistoryEntry = { n = '<enter>' },
    abort = { n = '<c-g>' },
    help = { n = 'g?' },
    toggleShowCommand = { n = '<localleader>!' },
    swapEngine = { n = '<localleader>e' },
    previewLocation = { n = '<localleader>p' },
    swapReplacementInterpreter = { n = '<localleader>x' },
  },
});
