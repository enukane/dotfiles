#!/bin/sh

echo move current .zshrc to .zshrc.bak
[ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.bak
echo make symlink to zshrc
ln -s zshrc ~/.zshrc

echo move current .vimrc to .vimrc.bak
[ -f ~/.vimrc ] && mv ~/.vimrc ~/.vimrc.bak
echo make symlink to vimrc
ln -s vimrc ~/.vimrc

echo move current .vim to .vim.bak
[ -f ~/.vim ] && mv ~/.vim ~/.vim.bak
echo make symlink to vimrc
ln -s vim ~/.vim
