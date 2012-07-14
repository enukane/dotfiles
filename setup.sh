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

echo move current .screenrc to .screenrc.bak
[ -f ~/.screenrc ] && mv ~/.screenrc ~/.screenrc.bak
echo make symlink to screenrc
ln -s ~/dotfiles/screenrc ~/.screenrc

echo move current .tmux.conf to .tmux.conf
[ -f ~/.tmux.conf ] && mv ~/.tmux.conf ~/.tmux.conf.bak
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf

source ~/.zshrc
