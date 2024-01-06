local colors = require("catppuccin.palettes").get_palette "frappe"

colors.fg_light = colors.text
colors.fg_transparent = "NONE"
colors.fg = colors.text
colors.fg_dark = colors.subtext0
colors.fg_darker = colors.overlay2

-- colors.bg_darkesst = 
-- colors.bg_darker = 
colors.bg_lightest = "#5B5F78"
colors.bg_lighter = "#454960"
colors.bg_light = "#3b3f52"
colors.bg = colors.base
colors.bg_dark = colors.mantle

colors.purple = colors.lavender
colors.blue = colors.blue
colors.green = colors.green
colors.red = colors.red
colors.orange = colors.peach
colors.yellow = colors.yellow

return colors
