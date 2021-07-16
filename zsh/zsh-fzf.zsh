export FZF_DEFAULT_COMMAND="fd --type file --follow --hidden --exclude .git --exclude node_modules"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--inline-info"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
