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
pkg_add zsh
echo INSTALLING vim
pkg_add vim
echo INSTALLING the_silver_searcher
pkg_add the_silver_searcher
echo INSTALLING xmonad
pkg_add xmonad
pkg_add xmonad-lib

echo xmonad >> /home/${USER}/.xsession

echo "REBOOT to enable settings"
echo "also don't forget to run..."
echo "setup.sh and visudo"
