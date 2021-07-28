# Add rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
if command -v rbenv 1>/dev/null 2>&1; then
  eval "$(rbenv init -)"
fi
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

# Add pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Yarn
if command -v yarn 1>/dev/null 2>&1; then
  export PATH="$PATH:$HOME/.yarn/bin"
fi

# Cargo
export PATH="$PATH:$HOME/.cargo/bin"

# Go
export PATH=$PATH:/usr/local/go/bin

# asdf
. /opt/asdf-vm/asdf.sh
