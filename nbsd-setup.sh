#!/bin/sh

# run as root
# install git & sudo first
sudo pkgin install zsh
sudo pkgin install vim
sudo pkgin install tmux
sudo pkgin install wget
sudo pkgin install the_silver_searcher
# no xmonad!

git config --global user.email enukane@glenda9.org
git config --global user.name enukane

chsh -s `which zsh`

mkdir ~/certs
curl http://curl.haxx.se/ca/cacert.pem -o ~/certs/cacert.pem
echo "[http]" >> ~/.gitconfig
echo "sslCAinfo= ${HOME}/certs/cacert.pem" >> ~/.gitconfig


echo "also don't forget to run..."
echo "setup.sh and visudo"

