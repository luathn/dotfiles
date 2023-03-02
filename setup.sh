ln -s -f ~/dotfiles/config/* ~/.config

mkdir ~/.zsh
ln -s -f ~/dotfiles/zsh/* ~/.zsh
ln -s -f ~/dotfiles/zshrc ~/.zshrc

ln -s -f ~/dotfiles/tmux.conf ~/.tmux.conf
ln -s -f ~/dotfiles/ctags ~/.ctags

ln -s -f ~/dotfiles/gitconfig ~/.gitconfig
ln -s -f ~/dotfiles/gitignore_global ~/.gitignore_global

ln -s -f ~/dotfiles/ssh/config ~/.ssh/config

rm -r -f ~/.config/nvim
ln -s -f ~/dotfiles/vim ~/.config/nvim

# ln -s -f ~/dotfiles/Xresources ~/.Xresources

# rm -r -f ~/.fonts
# ln -s -f ~/dotfiles/fonts ~/.fonts

nvim +PlugInstall +qall
