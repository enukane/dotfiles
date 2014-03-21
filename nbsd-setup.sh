#!/bin/sh

# run as root
# install git & sudo first
sudo pkgin install zsh
sudo pkgin install vim
sudo pkgin install tmux
sudo pkgin install wget
sudo pkgin install the_silver_searcher
sudo pkgin install xmonad

git config --global user.email enukane@glenda9.org
git config --global user.name enukane

chsh -s `which zsh`

echo "also don't forget to run..."
echo "setup.sh and visudo"

