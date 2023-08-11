local colors = require("tokyonight.colors").setup()

colors.fg_transparent = "NONE"

colors.bg = colors.bg
colors.bg_dark = colors.bg_dark
colors.bg_light = colors.bg_highlight
colors.bg_lighter = colors.terminal_black
-- if vim.o.background == "light" then
--   colors.bg = "#ced2de"
--   colors.bg_highlight = "#c4c8da"
--   colors.fg_dark = colors.dark5
-- else
--   colors.true_bg = "#1a1b26"
-- end

return colors
