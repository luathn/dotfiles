# Basic status bar colors
set -g status-style bg="#292C3C",fg=white

# Status
set -g status-left-length 40
set -g status-right-length 140
set -g status-left "#[fg=#292C3C,bg=#8CAAEE,bold] #S #[fg=#8CAAEE,bg=#292C3C]"
set -g status-right "#[fg=#454960,bg=#292C3C]#[fg=white,bg=#454960] %h %d %b #[fg=white,bg=#454960]#[fg=white,bg=#454960] %H:%M #[fg=#99D1DB,bg=#454960]#[fg=#292C3C,bg=#99D1DB,bold] #H "

# Windows
set -g window-status-format "#[fg=#292C3C,bg=#454960] #[fg=white,bg=#454960]#I #[fg=white,bg=#454960] #[fg=white,bg=#454960]#W #F #[fg=#454960,bg=#292C3C]"
set -g window-status-current-format "#[fg=#292C3C,bg=#99D1DB] #[fg=#292C3C,bg=#99D1DB]#I #[fg=#292C3C,bg=#99D1DB] #[fg=#292C3C,bg=#99D1DB]#W #F #[fg=#99D1DB,bg=#292C3C]"
set -g window-status-separator ""

# Pane border
set -g pane-border-style bg=default,fg="#232634"

# Active pane border
set -g pane-active-border-style bg=default,fg="#5B5F78"

# Pane number indicator
set -g display-panes-colour default
set -g display-panes-active-colour default

# Clock mode
set -g clock-mode-colour "#99D1DB"
set -g clock-mode-style 24

# Message
set -g message-style bg=default,fg=default

# Command message
set -g message-command-style bg=default,fg=default

# Mode
set -g mode-style bg=#99D1DB,fg=black
