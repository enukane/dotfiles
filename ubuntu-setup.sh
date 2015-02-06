#!/bin/sh

echo "==========================="
echo "= Initializer for new Env ="
echo "==========================="
echo ""

echo ">> Installing required packages"
echo "============================="
echo "=                           ="
echo "=         - vim             ="
echo "=         - tmux            ="
echo "=         - git             ="
echo "=         - zsh             ="
echo "=         - screen          ="
echo "=                           ="
echo "============================="

echo -n ">> enter YES to proceed: "
read line

if [ "${line}" != "YES" ]; then
  echo "Abort"
  exit 1
fi

echo -n ">> checking previledge: "
if [ "${USER}" != "root" ]; then
  echo  "${USER} is not root!"
  exit 2
fi

echo ">> proceed to installing"
aptitude install vim tmux git zsh screen

echo ">> done"

echo ">> Setting up git config"
git config --global user.email enukane@glenda9.org
git config --global user.name enukane
echo ">> done"

echo ">> Cloning dotfiles"
git clone https://github.com/enukane/dotfiles.git $HOME/dotfiles
echo ">> done"

echo ">> Changing shell to zsh"
chsh -s `which zsh`
echo ">> done"

echo ">> Initializer done"

echo "also don't forget to run.."
echo "setup.sh"
