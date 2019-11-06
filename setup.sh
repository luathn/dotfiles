ln -s -f ~/dotfiles/config/* ~/.config
ln -s -f ~/dotfiles/zshrc ~/.zshrc
ln -s -f ~/dotfiles/tmux.conf ~/.tmux.conf
rm -rf ~/.vim
ln -s -f ~/dotfiles/vim/ ~/.vim
ln -s -f ~/dotfiles/Xresources ~/.Xresources

vim +PlugInstall +qall
