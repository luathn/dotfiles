# Catppuccin Frappe (simple)

# Status bar
set -g status-style bg="#626880",fg="#C6D0F5"
set -g status-left-length 40
set -g status-right-length 80
set -g status-left "#[fg=#8CAAEE,bold] #S "
set -g status-right "#[fg=#C6D0F5] %d %b %H:%M #[fg=#99D1DB,bold]#H "

# Windows
set -g window-status-format " #I:#W#F "
set -g window-status-current-format "#[fg=#292C3C,bg=#99D1DB,bold] #I:#W#F "
set -g window-status-separator ""
set -g window-status-style default
set -g window-status-current-style default

# Pane borders
set -g pane-border-style fg="#414559"
set -g pane-active-border-style fg="#99D1DB"

# Clock mode
set -g clock-mode-colour "#99D1DB"
set -g clock-mode-style 24

# Messages and mode
# The prompt covers the full status line (width=100%), so the tabs do not show next to the prompt text.
set -g message-style bg="#626880",fg="#C6D0F5",fill="#626880",width=100%
set -g message-command-style bg="#626880",fg="#C6D0F5",fill="#626880",width=100%
set -g mode-style bg="#99D1DB",fg="#292C3C"
