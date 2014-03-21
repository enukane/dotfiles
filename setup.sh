#!/bin/sh

DATE=`date "+%Y%m%d%H%M.%S"`

echo move current dotfiles/.zshrc to .zshrc.bak.$DATE
[ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.bak.$DATE
echo make symlink to zshrc
ln -s ~/dotfiles/zshrc ~/.zshrc

echo move current .vimrc to .vimrc.bak.$DATE
[ -f ~/.vimrc ] && mv ~/.vimrc ~/.vimrc.bak.$DATE
echo make symlink to vimrc
ln -s ~/dotfiles/vimrc ~/.vimrc

echo move current .vim to .vim.bak.$DATE
[ -d ~/.vim ] && mv ~/.vim ~/.vim.bak.$DATE
echo make symlink to vimrc
ln -s ~/dotfiles/vim ~/.vim

echo make swap dir for vim
mkdir ~/.swp

echo move current .screenrc to .screenrc.bak.$DATE
[ -f ~/.screenrc ] && mv ~/.screenrc ~/.screenrc.bak.$DATE
echo make symlink to screenrc
ln -s ~/dotfiles/screenrc ~/.screenrc

echo move current .tmux.conf to .tmux.conf.bak.$DATE
[ -f ~/.tmux.conf ] && mv ~/.tmux.conf ~/.tmux.conf.bak.$DATE
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf

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

echo "##########################################################"
echo "# setup is done. type "source ~/.zshrc" to enable config #"
echo "##########################################################"
