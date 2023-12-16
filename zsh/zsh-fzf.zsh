export FZF_DEFAULT_COMMAND="fd --type file --follow --hidden --exclude .git --exclude node_modules"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='
    --inline-info
    --bind ctrl-o:toggle-all
    --color=hl:#ea76cb
    --color=fg+:#4d4d4c,bg+:#dce0e8,hl+:#ea76cb
    '

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
