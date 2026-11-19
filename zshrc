setopt correct
# Improve history
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.
setopt APPEND_HISTORY            # append to history file
setopt HIST_NO_STORE             # Don't store history commands

source ~/.zsh/zsh-defer/zsh-defer.plugin.zsh

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:$PATH

# Add homebrew
export PATH=/opt/homebrew/bin:$PATH

# asdf
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# Key binding #################################################################
stty -ixon

# vi mode
bindkey -v
bindkey "^a" beginning-of-line
bindkey "^e" end-of-line
bindkey "^b" backward-char
bindkey "^f" forward-char
bindkey "^u" kill-whole-line
bindkey "^w" backward-kill-word
bindkey "^n" history-search-forward
bindkey "^p" history-search-backward
bindkey "^ " autosuggest-accept
bindkey '^?' backward-delete-char
bindkey "^s" history-incremental-search-backward
# bindkey "jk" vi-cmd-mode

export EDITOR="nvim"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

alias ls="ls --color=auto"
alias gst="git status"

# Zsh Defer
zsh-defer source ~/.zsh/zsh-fzf.zsh
zsh-defer source ~/.zsh/zsh-export-path.zsh
zsh-defer source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
zsh-defer source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source ~/.zsh_local

function ai_helper() {
  local current_buffer=$BUFFER
  BUFFER=$(~/dotfiles/llm.sh "$current_buffer. Output only the raw bash command as plain text, with no Markdown, code fences, backticks or explanation.")
  CURSOR=${#BUFFER}
}
zle -N ai_helper
bindkey '^h' ai_helper

# My custom zsh prompt
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '
setopt PROMPT_SUBST
PROMPT='%F{blue}%~%f %F{red}${vcs_info_msg_0_}%f
$ '

# set history size
export HISTSIZE=10000

# save history after logout
export SAVEHIST=10000

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"
