#! /bin/bash
info () {
  printf "\r  [\033[00;34m..\033[0m] $1\n"
}

success () {
  printf "\r\033[2K [\033[00;32mOK\033[0m] $1\n"
}

install_chrome() {
  read -r -p "Do you want to install chrome? [y|N] " response
  if [[ $response =~ (y|yes|Y) ]];then
    info "Installing Google Chrome"
    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
    sudo apt update -y
    sudo apt install google-chrome-stable
    success "Installed Google Chrome"
  fi
}

install_git() {
  read -r -p "Do you want to install Git? [y|N] " response
  if [[ $response =~ (y|yes|Y) ]];then
    info "Installing Git"
    sudo add-apt-repository ppa:git-core/ppa
    sudo apt update -y
    sudo apt install git -y
    success "Installed Git"
  fi
}

install_interface_app() {
  read -r -p "Do you want to install Bspwm, polybar, rofi,...? [y|N] " response
  if [[ $response =~ (y|yes|Y) ]];then
    info "Installing Bspwm, polybar, rofi,..."
    sudo apt install bspwm rofi feh -y
    sudo apt install build-essential cmake cmake-data pkg-config python3-sphinx libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev libnl-genl-3-dev -y
    mkdir ~/buildapp
    cd ~/buildapp
    git clone --recursive https://github.com/polybar/polybar
    cd polybar
    mkdir build
    cd build
    cmake ..
    make -j$(nproc)
    sudo make install
    success "Installed"
  fi
}

install_zsh() {
  read -r -p "Do you want to install Zsh? [y|N] " response
  if [[ $response =~ (y|yes|Y) ]];then
    info "Installing Zsh"
    sudo apt install zsh -y
    sudo chsh -s $(which zsh)
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone https://github.com/romkatv/zsh-defer.git ~/.zsh/zsh-defer
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
    git clone https://github.com/rupa/z.git ~/.zsh/z
    success "Installed Zsh"
  fi
}

install_docker() {
  read -r -p "Do you want to install Docker? [y|N] " response
  if [[ $response =~ (y|yes|Y) ]];then
    info "Installing Docker"
    sudo apt-get remove docker docker-engine docker.io containerd runc
    sudo apt-get update -y
    sudo apt-get install \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg-agent \
        software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) \
       stable"
    sudo apt-get update -y
    sudo apt-get install docker-ce docker-ce-cli containerd.io -y
    success "Installed Docker"
  fi
}

install_docker_compose() {
  read -r -p "Do you want to install Docker Compose? [y|N] " response
  if [[ $response =~ (y|yes|Y) ]];then
    sudo curl -L "https://github.com/docker/compose/releases/download/1.28.6/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    success "Docker Compose Installed"
  fi
}

install_rbenv() {
  read -r -p "Do you want to install Ruby? [y|N] " response
  sudo apt-get install -y libssl-dev zlib1g-dev
  if [[ $response =~ (y|yes|Y) ]];then
    info "Installing Ruby"
    cd
    git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    cd ~/.rbenv && src/configure && make -C src
    ~/.rbenv/bin/rbenv init
    mkdir -p "$(rbenv root)"/plugins
    git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
    success "Installed Ruby"
  fi
}

install_node() {
  read -r -p "Do you want to install Node? [y|N] " response
  if [[ $response =~ (y|yes|Y) ]];then
    info "Installing Node"
    curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
    sudo apt-get install -y nodejs
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt update && sudo apt install -y yarn
    success "Installed Node"
  fi
}

install_nvim() {
  sudo apt update
  sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip -y
  sudo apt install xclip -y
  mkdir ~/buildapp
  cd ~/buildapp
  git clone https://github.com/neovim/neovim.git
  cd neovim
  make
  sudo make install
}

install_command_line_tools() {
  sudo apt install bat -y
  mkdir ~/buildapp
  cd ~/buildapp
  curl -LO https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep_12.1.1_amd64.deb
  sudo dpkg -i ripgrep_12.1.1_amd64.deb
  curl -LO https://github.com/sharkdp/fd/releases/download/v8.2.1/fd_8.2.1_amd64.deb
  sudo dpkg -i fd_8.2.1_amd64.deb
}

install_asdf() {
  sudo git clone https://github.com/asdf-vm/asdf.git /opt/asdf-vm
  git -C ~/.asdf checkout "$(git -C ~/.asdf describe --abbrev=0 --tags)"
}

# Install general ##############################################
sudo apt-get install build-essential zsh vim tmux curl scrot mpd ncmpcpp -y

# install_rbenv

install_chrome
install_git
install_interface_app
install_zsh
install_docker
install_docker_compose
install_node
install_command_line_tools
install_nvim
install_asdf
