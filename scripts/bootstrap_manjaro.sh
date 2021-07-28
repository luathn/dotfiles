# Install Yay
install_yay() {
  sudo pacman -S --needed git base-devel
  git clone https://aur.archlinux.org/yay.git ~/buildapp/yay
  cd ~/buildapp/yay
  makepkg -si
}

setup_zsh() {
  sudo chsh -s $(which zsh)
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  git clone https://github.com/romkatv/zsh-defer.git ~/.zsh/zsh-defer
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
}

mkdir ~/buildapp

install_yay

# Install app
yay -S neovim xsel fd ripgrep bat --noconfirm

# Install app via AUR
yay -S asdf-vm --noconfirm

setup_zsh
