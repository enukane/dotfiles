### lang
export	LANG=ja_JP.UTF-8
export	LC_ALL=ja_JP.UTF-8
export	LC_CTYPE=ja_JP.UTF-8
export	LC_MESSAGES=ja_JP.UTF-8

case ${UID} in
0) # when root 
    LANG=C
    ;;
esac

export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

### module
#setopt share_history # share history between terminals
setopt append_history # append later history
setopt hist_no_store # exclude history command
setopt hist_reduce_blanks # reduce blanks
setopt auto_pushd # cd - + tab to show navigation
setopt pushd_ignore_dups # ignore dupd pushd
setopt listtypes # completion candidates are signed

setopt correct
#zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'

autoload -U compinit
compinit
zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'so=32' 'pi=33' 'ex=31' 'bd=46;34' 'cd=43;34' 'su=41;30' 'sg=46;30' 'tw=42;30' 'ow=43;30'


setopt auto_cd

setopt noautoremoveslash

setopt nolistbeep # no beep

setopt prompt_subst
autoload -U colors
colors

### variables
#PROMPT="[%B%n%b@\e%m] %~ %# "
local WHITE=$'%{\e[1;37m%}'
local CYAN=$'%{\e[1;36m%}'
local GREEN=$'%{\e[1;32m%}'
local YELLOW=$'%{\e[1;33m%}'
local BLUE=$'%{\e[1;34m%}'
local RED=$'%{\e[1;31m%}'
local CLEARBLUE=$'%{\e[1;36m%}'
local DEFAULT=$'%{\e[1;0m%}'
PROMPT="$WHITE%B%n%b@$GREEN%m$DEFAULTなう（´・ω・｀）つ "
PROMPT="[$WHITE%B%n%b@$GREEN%m$DEFAULT] $CYAN%~$DEFAULT %# "
RPROMPT="(%W %T)"

HISTFILE=~/.zshhistory
HISTSIZE=50000
SAVEHIST=50000
export EDITOR=vim

### path
PLAN9=$HOME/plan9 export PLAN9
PATH=$PATH:$PLAN9/bin:/usr/local/bin export PATH
PATH=$HOME/Gentoo/usr/bin/:$PATH
PATH=$HOME/usr/local/bin:$PATH
PATH=/usr/pkg/bin/:$HOME/bin/:$PATH
PATH=/sbin/:~/usr/bin/:$PATH

export LESS="-R"

### alias
alias ls="ls -F"
alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"
alias scrr='screen -U -D -RR'
alias s='screen -U'
alias up="cd ../;"
#alias diff=colordiff

# stderrred
#
# stderrred
export LIBSTDERRRED="/home/nkaneko/Sources/stderred/lib/stderred.so"
if [ -f $LIBSTDERRRED  ]; then
        export LD_PRELOAD=$LIBSTDERRRED
fi


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

function forcerm() {
	echo "force removing $1"
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
	
	/bin/rm -rf $1
	echo "$1 is permanently gone...."
}

## machine specific
[ -f ~/.zshrc.local ] && source ~/.zshrc.local


