########################################
###
### module
###
########################################

### setopt definitions
## share history between terminals
unsetopt share_history # it's annoying... let me use per-terminal history...
# append later history
setopt append_history
# exclude history command
setopt hist_no_store
# reduce blanks in history
setopt hist_reduce_blanks
# cd - + tab to show navigation
setopt auto_pushd
# ignore dupd pushd
setopt pushd_ignore_dups
# completion candidates are signed
setopt listtypes
# check spell
setopt correct
# automatically cd to directory
setopt auto_cd
# never remove slash terminating directory name
setopt noautoremoveslash
# never beeps
setopt nolistbeep
setopt prompt_subst

### autoloads
autoload -U compinit
compinit

zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'so=32' 'pi=33' 'ex=31' 'bd=46;34' 'cd=43;34' 'su=41;30' 'sg=46;30' 'tw=42;30' 'ow=43;30'
autoload -U colors
colors

# show git branch
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '%s][* %F{green}%b%f'
zstyle ':vcs_info:*' actionformats '%s][* %F{green}%b%f(%F{red}%a%f)'
precmd () { vcs_info }

bindkey -e


########################################
###
### variables
###
########################################

### terminal config related
export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export HISTFILE=~/.zshhistory
export HISTSIZE=50000
export SAVEHIST=50000
export EDITOR=vim
export LESS='-g -i -M -R -S -W -z-4 -x4'
#### separate ctrl+w with '/'
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

## host specific variables
[ -f ~/.zshrc.local.variables ] && source ~/.zshrc.local.variables


########################################
###
### PATH
###
########################################

## subpath definitions
# basic
export PATH=/bin:/sbin/:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
# plan9 port
export PLAN9PATH=$HOME/plan9
# Gentoo
export GENTOOPATH=$HOME/Gentoo/usr/bin
# pkgsrc
export PKGSRCPATH=/usr/pkg/bin:/usr/pkg/sbin:$HOME/usr/pkg/bin:$HOME/usr/pkg/sbin
# home bin
export HOMEBINPATH=$HOME/bin:$HOME/bin/utils:$HOME/usr/bin:$HOME/usr/local/bin
# rbenv
export RBENVPATH=$HOME/.rbenv/shims
# cargo
export CARGOPATH=$HOME/.cargo/bin
# go
export GOBINPATH=/usr/local/go/bin
#export GOPATH=$HOME/go
export GOPATH=$HOME/go
#export GOMYBINPATH=$GOPATH/bin
export GOMYBINPATH="$HOME/go/bin"
# SDCC
export SDCCPATH=/Developer/SDCC/bin
# mactex
export MACTEXPATH=/usr/local/texlive/2013/bin/x86_64-darwin
# ADT
export ADTPATH=/Applications/eclipse/android/platform-tools
# X11R7
export XELVPATH=/usr/X11R7/bin/

## left path
PATH=$PLAN9PATH:$PATH
PATH=$GENTOOPATH:$PATH
PATH=$PKGSRCPATH:$PATH
PATH=$RBENVPATH:$PATH
PATH=$CARGOPATH:$PATH
PATH=$HOMEBINPATH:$PATH
PATH=$GOBINPATH:$PATH
PATH=$GOMYBINPATH:$PATH
PATH=$SDCCPATH:$PATH
PATH=$MACTEXPATH:$PATH
PATH=$ADTPATH:$PATH
## right path
PATH=$PATH:$XELVPATH

## additional
#export RBENVGEMPATH=$HOME/.rbenv/versions/`ruby -v | cut -d " " -f 2 | sed -e 's/p/-p/g'`/bin
#PATH=$RBENVGEMPATH:$PATH

## host specific path
[ -f ~/.zshrc.local.path ] && source ~/.zshrc.local.path


########################################
###
### alias
###
########################################
alias ls="ls -F"
alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"
alias scrr='screen -U -D -RR'
alias s='screen -U'
alias up="cd ../;"
`which ag` > /dev/null 2>&1  && [ -f `which ag` ] && alias grep=ag
alias g="ag"
alias v="vim"
alias im="vim"
alias m="vim"
alias gits="git status --short --branch"



########################################
###
### commands
###
########################################
#
############################
### misc                  ##
############################

function colorcheck() {
	echo ${WHITE}white${CYAN}cyan${GREEN}green${YELLOW}yellow${BLUE}blue
	echo ${MAGENDA}magenda${RED}red${LIGHTRED}lightred${CLEARBLUE}clearblue
	echo ${BACKRED}backred${DEFAULT}default
}

function md() {
	mkdir -p "$@" && cd "$1"
}

#############################
## rm : rm with recyclebin ##
#############################
# description:
#     rm with recyclebin
#     lesson : one must not use rm directly...sigh
# usage:
#     rm <target>

# recyclebin
export RMBIN=$HOME/.recyclebin/

# mv to recycle bin
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

# make rm backup
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

#########
## cdd ##
#########
# description:
#     remember directory and jump there directly
# usage:
#     # remember current directory
#       $ regd
#     # jump there
#       $ cdd
#     # forget directory
#       $ unregd

# directory is memo'ed here
REGD=$HOME/.cdd
# cd to memorized directory
function cdd() {
if [ -e "$REGD" ] ; then
	cd `cat $REGD`
else
	echo "no directory registered"
	cd $HOME
fi
}

# memorize directory
function regd() {
	PWD=`pwd`
	echo $PWD > $REGD
	echo "directory registered : `cat $REGD`"
}

# forget directory
function unregd() {
	echo "directory unregistered : `cat $REGD`"
}

function echod() {
	echo -n `cat $REGD`
}

# reload zshrc
function reload() {
        source $HOME/.zshrc
}

function cd2macinclude() {
	cd /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/
}

# zip with password
function zipdirpass() {
	# $1 : target to compress
	# $2 : output (*.zip9
	local target=$1
	local output=$2

	if [ "x$1" = "x-h" ]; then
		echo "zipdirpass targetdir output"
		return 0
	fi
	if [ ! $output ]; then
		output=$1.zip
	fi

	echo "Compressing target='$target' into '$output' with password"
	zip -e -r $output $target
}

function console() {
	$HOME/bin/utils/console
}

function cphere() {
	cp $1 ./
}

function cpdirhere() {
	cp -r $1 ./
}

## host specific commands
[ -f ~/.zshrc.local.command ] && source ~/.zshrc.local.command



########################################
###
### lang
###
########################################
## locales
export	LANG=ja_JP.UTF-8
export	LC_ALL=ja_JP.UTF-8
export	LC_CTYPE=ja_JP.UTF-8
export	LC_MESSAGES=ja_JP.UTF-8

## special locale for root : always C
case ${UID} in
0) # when root 
    LANG=C
    LC_ALL=C
    ;;
esac

case ${TERM} in
xterm|screen|vt100|vt220) #when xterm
	LANG=C
	LC_ALL=C
	;;
*)
	;;
esac

## host local locale >> ~/.zshrc.local.lang
[ -f ~/.zshrc.local.lang ] && source ~/.zshrc.local.lang



########################################
###
### Prompt
###
########################################

## color definition
local WHITE=$'%{\e[1;37m%}'
local CYAN=$'%{\e[1;36m%}'
local GREEN=$'%{\e[1;32m%}'
local YELLOW=$'%{\e[1;33m%}'
local BLUE=$'%{\e[1;94m%}'
local RED=$'%{\e[1;31m%}'
local LIGHTRED=$'%{\e[1;91m%}'
local CLEARBLUE=$'%{\e[1;36m%}'
local BACKRED=$'%{\e[1;41m%}'
local DEFAULT=$'%{\e[1;0m%}'

## host severity (SEVERITY) defined here
SEVERITY=0
local PROMPTCOLOR=${BLUE}
[ -f ~/.zshrc.local.severity ] && source ~/.zshrc.local.severity
echo ${SEVERITY}
case ${SEVERITY} in
1)
	# watch!: main machine
	PROMPTCOLOR=${GREEN}
	;;
2)
	# watch out!: shared machine (don't mess)
	PROMPTCOLOR=${YELLOW}
	;;
3)
	# high: server or hub, don't be stupid
	PROMPTCOLOR=${RED}
	;;
4)
	# dangerous
	PROMPTCOLOR=${DEFAULT}${BACKRED}
	;;
"0"|*)
	# don't care: default
	PROMPTCOLOR=${BLUE}
	;;
esac


## RPROMPT
# default PROMPT
#PROMPT="[%B%n%b@\e%m] %~ %# "
# PROMPT definition
case ${LANG} in
C)
	PROMPT="[$WHITE%B%n%b@${PROMPTCOLOR}%m$DEFAULT] $CYAN%~$DEFAULT %# "
	;;
*)
	PROMPT="$WHITE%B%n%b@${PROMPTCOLOR}%m$DEFAULTなう（´・ω・｀）つ %~$DEFAULT
%# "
	;;
esac

case ${TERM} in
xterm|screen|vt100|vt220)
	PROMPT="[$WHITE%B%n%b@${PROMPTCOLOR}%m$DEFAULT] $CYAN%~$DEFAULT %# "
	;;
*)
	;;
esac

# RPROMPT
RPROMPT="[${vcs_info_msg_0_}](%W %T)"

# host specific prompt
[ -f ~/.zshrc.local.prompt ] && source ~/.zshrc.local.prompt



########################################
###
###  other
###
########################################
## rbenv
`which rbenv` > /dev/null 2>&1  && eval "$(rbenv init -)"
`which rbenv` > /dev/null 2>&1 && export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

## pyenv
if type pyenv >/dev/null 2>&1 ; then
	echo PYENV
	PYENV_ROOT=~/.pyenv
	#export VIRTUAL_ENV_DISABLE_PROMPT=1
	export PATH=$PYENV_ROOT/bin:$PATH
	eval "$(pyenv init -)"
	#eval "$(pyenv virtualenv-init -)"
fi

########################################
###
### host specific general
###
########################################
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

PATH="/Users/enukane/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/enukane/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/enukane/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/enukane/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/enukane/perl5"; export PERL_MM_OPT;


#. /Users/enukane/torch/install/bin/torch-activate

# disable bracket paste mode off
printf '\e[?2004l'
#eval $(/usr/libexec/path_helper -s)
