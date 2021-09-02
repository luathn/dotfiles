local colors = require("tokyonight.colors").setup()
colors.fg_transparent = "NONE"
colors.bg = colors.bg_dark
if vim.o.background == "light" then
  colors.bg = "#ced2de"
  colors.bg_highlight = "#c4c8da"
  colors.fg_dark = colors.dark5
end

return colors
