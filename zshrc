### lang
export	LANG=ja_JP.UTF-8
export	LC_ALL=ja_JP.UTF-8
export	LC_CTYPE=ja_JP.UTF-8
export	LC_MESSAGES=ja_JP.UTF-8

case ${UID} in
0) # when root 
    LANG=C
    LC_ALL=C
    ;;
esac


### module
#setopt share_history # share history between terminals
setopt append_history # append later history
setopt hist_no_store # exclude history command
setopt hist_reduce_blanks # reduce blanks
setopt auto_pushd # cd - + tab to show navigation
setopt pushd_ignore_dups # ignore dupd pushd
setopt listtypes # completion candidates are signed
setopt correct
setopt auto_cd
setopt noautoremoveslash
setopt nolistbeep # no beep
setopt prompt_subst

autoload -U compinit
compinit

zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'so=32' 'pi=33' 'ex=31' 'bd=46;34' 'cd=43;34' 'su=41;30' 'sg=46;30' 'tw=42;30' 'ow=43;30'
autoload -U colors
colors

### variables
export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
#PROMPT="[%B%n%b@\e%m] %~ %# "
local WHITE=$'%{\e[1;37m%}'
local CYAN=$'%{\e[1;36m%}'
local GREEN=$'%{\e[1;32m%}'
local YELLOW=$'%{\e[1;33m%}'
local BLUE=$'%{\e[1;34m%}'
local RED=$'%{\e[1;31m%}'
local CLEARBLUE=$'%{\e[1;36m%}'
local DEFAULT=$'%{\e[1;0m%}'

case ${LANG} in
C)
	PROMPT="[$WHITE%B%n%b@$GREEN%m$DEFAULT] $CYAN%~$DEFAULT %# "
	;;
*)
	PROMPT="$WHITE%B%n%b@$GREEN%m$DEFAULTなう（´・ω・｀）つ "
	;;
esac
RPROMPT="(%W %T)"

HISTFILE=~/.zshhistory
HISTSIZE=50000
SAVEHIST=50000
export EDITOR=vim

### path
#### plan9port
export PLAN9PATH=$HOME/plan9
#### Gentoo
export GENTOOPATH=$HOME/Gentoo/usr/bin
#### PKGSRC
export PKGSRCPATH=/usr/pkg/bin:/usr/pkg/sbin
#### HOMEBINPATH
export HOMEBINPATH=$HOME/bin:$HOME/usr/bin:$HOME/bin/utils

#### PATH
export PATH=/bin/:/sbin/:/usr/bin/:/usr/sbin
PATH=/usr/local/bin/:$PATH
PATH=$PLAN9PATH:$PATH
PATH=$GENTOOPATH:$PATH
PATH=$PKGSRCPATH:$PATH
PATH=$HOMEBINPATH:$PATH

### alias
alias ls="ls -F"
alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"
alias scrr='screen -U -D -RR'
alias s='screen -U'
alias up="cd ../;"

# stderrred
export LIBSTDERRRED="/home/nkaneko/Sources/stderred/lib/stderred.so"
if [ -f $LIBSTDERRRED  ]; then
        export LD_PRELOAD=$LIBSTDERRRED
fi


# commands
export RMBIN=$HOME/.recyclebin/
function rmtobin() {
	RMDATE=`date "+%Y%m%d%H%M.%S"`
	RMDST=`echo $1 | sed -e 's/\//__/g'`
	DST=$RMBIN/$RMDST.$RMDATE
	if [ -e $DST ]; then
		#name already exists
		#echo "$DST already exists : try later"
		#return 1
	fi
	echo "clear to $DST"
	mv $1 $DST
}

## make rm backup
function rm() {
	if [ -d $RMBIN ]; then 
		;
	else
		echo "$RMBIN not exists : create directory"
		mkdir $RMBIN || return
	fi
	
	while [ $1 ]; do
		if [ -e "$1" ] ; then
			rmtobin $1
		fi
		shift
	done
}

# this is true rm
function forcerm() {
	echo "force removing $*"
	echo "is this ok ? (y/N) :"
	read ans
	case $ans in
		[yY])
			echo "remove entry"
			;;
		[nN])
			echo "abandon removing. bye"
			return 1
			;;
		*)
			echo "wrong answer. abort"
			return 2
			;;
	esac
	
	/bin/rm -rf $*
	echo "$* is permanently gone...."
}

REGD=$HOME/.cdd

function cdd() {
if [ -e "$REGD" ] ; then
	cd `cat $REGD`
else
	echo "no directory registered"
	cd $HOME
fi
}

function regd() {
PWD=`pwd`
echo $PWD > $REGD
echo "directory registered : `cat $REGD`"
}

function unregd() {
echo "directory unregistered : `cat $REGD`"
}


## machine specific
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
