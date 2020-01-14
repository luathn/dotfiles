# Basic status bar colors
set -g status-style bg=black,fg=colour241

# Left side of status bar
set -g status-left-style bg=black,fg=green
set -g status-left-length 40
set -g status-left "#[bg=colour232,fg=white] #S #[bg=black] "

# Right side of status bar
set -g status-right "#H « %H:%M %d-%b-%y"

# Window status
set -g window-status-format " #W "
set -g window-status-current-format " #W:#F "
set -g window-status-current-style bg=black,fg=white
set -g status-justify left

# Window separator
set -g window-status-separator ""

# Pane border
set -g pane-border-style bg=default,fg=colour232

# Active pane border
set -g pane-active-border-style bg=default,fg=colour247

# Pane number indicator
set -g display-panes-colour default
set -g display-panes-active-colour default

# Clock mode
set -g clock-mode-colour red
set -g clock-mode-style 24

# Message
set -g message-style bg=default,fg=default

# Command message
set -g message-command-style bg=default,fg=default

# Mode
set -g mode-style bg=green,fg=black
