ln -s -f ~/dotfiles/config/* ~/.config
ln -s -f ~/dotfiles/zshrc ~/.zshrc
ln -s -f ~/dotfiles/tmux.conf ~/.tmux.conf
ln -s -f ~/dotfiles/ctags ~/.ctags

rm -r -f ~/.config/nvim
ln -s -f ~/dotfiles/vim ~/.config/nvim

ln -s -f ~/dotfiles/Xresources ~/.Xresources

rm -r -f ~/.fonts
ln -s -f ~/dotfiles/fonts ~/.fonts

vim +PlugInstall +qall
