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
#echo make symlink to vimrc
#ln -s ~/dotfiles/vim ~/.vim

echo make vim/bundle
mkdir -p ~/.vim/bundle/
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

echo make dein
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh $HOME/.dein

echo move current .swp to .swp.bak.$DATE
[ -d ~/.swp ] && mv ~/.swp ~/.swp.bak.$DATE
mkdir ~/.swp

echo make swap dir for vim
mkdir ~/.swp

echo move current .screenrc to .screenrc.bak.$DATE
[ -f ~/.screenrc ] && mv ~/.screenrc ~/.screenrc.bak.$DATE
echo make symlink to screenrc
ln -s ~/dotfiles/screenrc ~/.screenrc

echo move current .tmux.conf to .tmux.conf.bak.$DATE
[ -f ~/.tmux.conf ] && mv ~/.tmux.conf ~/.tmux.conf.bak.$DATE
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf

echo move current .tmux to .tmux.bak.$DATE
[ -f ~/.tmux ] && mv ~/.tmux ~/.tmux.bak.$DATE
ln -s ~/dotfiles/tmux ~/.tmux

backupandset() {
	echo "move current ${1} to ${1}.${DATE}"
	[ -f ~/.${1} ] && mv ~/.$1 ~/.${1}.bak.${DATE}
	echo make symlink to ${1}
	ln -s ~/dotfiles/${1} ~/.${1}

	return 1
}

backupandset Xdefaults
echo "##########################################################"
echo "# setup is done. type "source ~/.zshrc" to enable config #"
echo "##########################################################"
