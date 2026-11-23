# Status bar
set -g status-style bg="#626880",fg="#C6D0F5"
set -g status-left "#[fg=#8CAAEE,bold] #S "
set -g status-right "#[fg=#C6D0F5] %d %b %H:%M #[fg=#99D1DB,bold]#H "

# Windows
set -g window-status-format " #I:#W#F "
set -g window-status-current-format "#[fg=#292C3C,bg=#99D1DB,bold] #I:#W#F "
set -g window-status-current-style default

# Pane borders
set -g pane-border-style fg="#414559"
set -g pane-active-border-style fg="#99D1DB"
