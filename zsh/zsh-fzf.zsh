export FZF_DEFAULT_COMMAND="fd --type file --follow --hidden --exclude .git --exclude node_modules"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='
    --inline-info
    --bind ctrl-o:toggle-all
    --layout="reverse"
    '

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
