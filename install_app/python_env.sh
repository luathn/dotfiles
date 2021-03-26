install_pyenv() {
  cd
  git clone https://github.com/pyenv/pyenv.git ~/.pyenv
  cd ~/.pyenv && src/configure && make -C src
}

install_pyenv
