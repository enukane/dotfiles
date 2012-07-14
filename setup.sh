#!/bin/sh

echo move current dotfiles/.zshrc to .zshrc.bak
[ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.bak
echo make symlink to zshrc
ln -s ~/dotfiles/zshrc ~/.zshrc

echo move current .vimrc to .vimrc.bak
[ -f ~/.vimrc ] && mv ~/.vimrc ~/.vimrc.bak
echo make symlink to vimrc
ln -s ~/dotfiles/vimrc ~/.vimrc

echo move current .vim to .vim.bak
[ -d ~/.vim ] && mv ~/.vim ~/.vim.bak
echo make symlink to vimrc
ln -s ~/dotfiles/vim ~/.vim

source ~/.zshrc
