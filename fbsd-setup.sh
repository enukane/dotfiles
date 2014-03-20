#!/bin/sh

# run as root
# install git & sudo first
sudo pkg install zsh
sudo pkg install vim
sudo pkg install tmux

git config --global user.email enukane@glenda9.org
git config --global user.name enukane

chsh -s `which zsh`

echo "also don't forget to run..."
echo "setup.sh and visudo"

