setopt correct

source ~/.zsh/zsh-defer/zsh-defer.plugin.zsh

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:$PATH

# Add homebrew
export PATH=/opt/homebrew/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="amuse"

# docker docker-compose ruby tmux rails
plugins=(vi-mode git)

source $ZSH/oh-my-zsh.sh

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
bindkey "^s" history-incremental-search-backward
bindkey "^n" history-search-forward
bindkey "^p" history-search-backward
bindkey "^ " autosuggest-accept
bindkey "jk" vi-cmd-mode

export EDITOR="vim"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# asdf
case `uname` in
  Darwin)
    . /opt/homebrew/opt/asdf/libexec/asdf.sh
  ;;
  Linux)
    . /opt/asdf-vm/asdf.sh
  ;;
esac

export GOPATH="$(go env GOPATH)"
export PATH=${GOPATH}/bin:$PATH

# export SDKROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX14.2.sdk

# Zsh Defer

zsh-defer source ~/.zsh/zsh-fzf.zsh
zsh-defer source ~/.zsh/zsh-export-path.zsh
zsh-defer source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
zsh-defer source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

zsh-defer source ~/.zsh_local

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"
