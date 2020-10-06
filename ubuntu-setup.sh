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
echo "=         - curl          ="
echo "=                           ="
echo "============================="

echo -n ">> enter YES to proceed: "
read line

if [ "${line}" != "YES" ]; then
  echo "Abort"
  exit 1
fi

echo ">> proceed to installing"
sudo apt install vim tmux git zsh screen

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

echo ">> installing dein"
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > /tmp/installer.sh
sh /tmp/installer.sh ~/.cache/dein
echo ">> done"

echo ">> Initializer done"

echo "also don't forget to run.."
echo "setup.sh"
