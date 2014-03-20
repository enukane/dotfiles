#!/bin/sh

# run as root
# install git & sudo first

pkg install zsh
pkg install vim
pkg install tmux

git config --global user.email enukane@glenda9.org
git config --global user.name enukane

chsh -s `which zsh`

echo "also don't forget to run..."
echo "setup.sh and visudo"

