local colors = require("catppuccin.palettes").get_palette "latte"

colors.fg_transparent = "NONE"
colors.fg = colors.text
colors.fg_dark = "#414459"
colors.fg_darker = "#353747"

-- colors.bg_darkesst = 
-- colors.bg_darker = 
colors.bg_lightest = colors.overlay0
colors.bg_lighter = colors.surface1
colors.bg_light = colors.crust
colors.bg = colors.base
colors.bg_dark = colors.mantle

colors.purple = colors.lavender
colors.blue = colors.sky
colors.green = colors.green
colors.red = colors.red
colors.orange = colors.peach
colors.yellow = colors.yellow

return colors
