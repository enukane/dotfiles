#!/bin/sh

# run as root

USER=enukane
VERSION=snapshots
ARCH=amd64

export PKG_PATH="ftp://ftp.iij.ad.jp/pub/OpenBSD/${VERSION}/packages/${ARCH}/"
export PKG_CACHE="/home/${USER}/Downloads/OpenBSD/${VERSION}-${ARCH}-packages"

# we expect git to be installed
#echo INSTALLING git
#pkg_add git
echo INSTALLING zsh
sudo pkg_add zsh
echo INSTALLING vim
sudo pkg_add vim
echo INSTALLING the_silver_searcher
sudo pkg_add the_silver_searcher
echo INSTALLING xmonad
sudo pkg_add xmonad
sudo pkg_add xmonad-lib

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


echo "REBOOT to enable settings"
echo "also don't forget to run..."
echo "setup.sh and visudo"
