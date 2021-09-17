# Install Yay
install_yay() {
  sudo pacman -S --needed git base-devel
  git clone https://aur.archlinux.org/yay.git ~/buildapp/yay
  cd ~/buildapp/yay
  makepkg -si
}

mkdir ~/buildapp

install_yay

# Install dev tools
yay -S neovim alacritty tmux xsel fd ripgrep bat --noconfirm

# Install app
yay -S fcitx5-unikey fcitx5-configtool fcitx5-gtk --noconfirm

# Install app via AUR
yay -S asdf-vm --noconfirm

# Setup config
setup_zsh() {
  sudo chsh -s $(which zsh)
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  git clone https://github.com/romkatv/zsh-defer.git ~/.zsh/zsh-defer
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
  git clone https://github.com/rupa/z.git ~/.zsh/z
}

setup_unikey() {
  sudo -i
  echo "GTK_IM_MODULE=fcitx" >> /etc/environment
  echo "QT_IM_MODULE=fcitx" >> /etc/environment
  echo "XMODIFIERS=@im=fcitx" >> /etc/environment
}

setup_zsh
setup_unikey
