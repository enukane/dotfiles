#!/bin/sh

# run as root
# install git & sudo first

echo "============================="
echo "= install required packages ="
echo "=                           ="
echo "=         - vim             ="
echo "=         - tmux            ="
echo "=         - git             ="
echo "=         - zsh             ="
echo "=         - wget            ="
echo "=         - screen          ="
echo "=         - ag              ="
echo "=                           ="
echo "============================="
echo ""

sudo pkg install vim
sudo pkg install tmux
sudo pkg install git
sudo pkg install zsh
sudo pkg install wget
sudo pkg install screen
sudo pkg install the_silver_searcher

git config --global user.email enukane@glenda9.org
git config --global user.name enukane

chsh -s `which zsh`

echo "also don't forget to run..."
echo "setup.sh and visudo"

backupandset() {
	echo "move current ${1} to ${1}.${DATE}"
	[ -f ~/.${1} ] && mv ~/.$1 ~/.${1}.bak.${DATE}
	echo make symlink to ${1}
	ln -s ~/dotfiles/${1} ~/.${1}

	return 1
}

backupandset xinitrc
backupandset xsession
backupandset xmonad
backupandset xmobarrc


