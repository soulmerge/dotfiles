# start off with clean LD_PRELOAD
export LD_PRELOAD=

# set emacs mode
bindkey -e

# fix some keys
bindkey "[7~" beginning-of-line
bindkey "[8~" end-of-line
bindkey '[3~' delete-char

# reverse searching with <C-R>
bindkey '^R' history-incremental-search-backward

# save timestamp + duration of each command
setopt EXTENDED_HISTORY

# do not find duplicates when searching history
setopt HIST_FIND_NO_DUPS

# Expire duplicates first
setopt HIST_EXPIRE_DUPS_FIRST

# ignore duplicate lines in history
#setopt HIST_IGNORE_DUPS

# do not add lines with starting spaces to history
setopt HIST_IGNORE_SPACE

# do not add calls to `history` & co. to history
setopt HIST_NO_STORE

# enable comments in interactive mode
setopt interactive_comments

# word splitting for sh compatibility
setopt shwordsplit

# virtualenvwrapper
test -f /usr/bin/virtualenvwrapper.sh && source /usr/bin/virtualenvwrapper.sh

# trash
if test -f /usr/lib/libtrash.so; then
    alias trashon="export LD_PRELOAD=\"\$LD_PRELOAD /usr/lib/libtrash.so\""
    alias trashoff="export LD_PRELOAD=${LD_PRELOAD/\/usr\/lib\/libtrash.so/}"
elif test -f /usr/local/lib/libtrash.so; then
    alias trashon="export LD_PRELOAD=\"\$LD_PRELOAD /usr/local/lib/libtrash.so\""
    alias trashoff="export LD_PRELOAD=${LD_PRELOAD/\/usr\/local\/lib\/libtrash.so/}"
elif test -f /usr/local/bin/rm-trash; then
    alias trashon=""
    alias trashoff=""
    alias rm='rm-trash'
else
    alias trashon="echo no trash found >&2"
    alias trashoff="echo no trash found >&2"
    alias rm='rm -i'
fi
trashon

# stderred
if test -f /usr/local/lib64/libstderred.so; then
    alias stderredon='export LD_PRELOAD="$LD_PRELOAD /usr/local/lib64/libstderred.so"'
    alias stderredoff='export LD_PRELOAD="$(echo ${LD_PRELOAD/\/usr\/local\/lib64\/libstderred.so/}|sed s/\^\ //)"'
else
    alias stderredon="echo stderred not found"
    alias stderredoff="echo stderred not found"
fi
stderredon

# some apps won't will issue warnings with LD_PRELOAD
alias offlineimap="LD_PRELOAD= offlineimap"
alias firefox="LD_PRELOAD= firefox"
alias thunderbird="LD_PRELOAD= thunderbird"
alias wine="LD_PRELOAD= wine"
alias skype="LD_PRELOAD= skype"

# switching away from ack
alias ack="echo 'Use ag!' >&2; sleep 1; ag"

# environment variables
PATH=~/bin/:$PATH:/usr/local/wheelbin:/usr/games/bin/:
export PATH
export INPUTRC=$HOME/.inputrc
export EDITOR=vim
export MANPAGER="/usr/bin/less -isr"
export LANG=en_US.utf8
export TZ="Europe/Vienna"
export LESS="--ignore-case --chop-long-lines --raw-control-chars"

# aliases
alias ls="ls --color=tty"
alias cp='cp -i'
alias mv='mv -i'
alias grep='grep --exclude-dir=.svn --color=auto'

# common typos
alias sl="ls"
alias cim="vim"
alias vmi="vim"
alias vim.="vim ."

# big xterm for presentations
alias bigxterm='xterm -font -*-fixed-medium-r-*-*-20-*-*-*-*-*-iso8859-* -geometry 70x24'

# init keychain
keychain -q ~/.ssh/id_rsa
. ~/.keychain/panther-sh
. ~/.keychain/panther-sh-gpg

# colors:
black='%{[0;30m%}'
BLACK='%{[1;30m%}'
red='%{[0;31m%}'
RED='%{[1;31m%}'
green='%{[0;32m%}'
GREEN='%{[1;32m%}'
yellow='%{[0;33m%}'
YELLOW='%{[1;33m%}'
blue='%{[0;34m%}'
BLUE='%{[1;34m%}'
magenta='%{[0;35m%}'
MAGENTA='%{[1;35m%}'
cyan='%{[0;36m%}'
CYAN='%{[1;36m%}'
white='%{[0;37m%}'
WHITE='%{[1;37m%}'
NC='%{[0m%}'

# functions
ParentPid() {
	ps ax -o pid,ppid | awk "{if (\$1 == $1) print \$2}"
}

IsRemoteLogin() {
	type pidof >/dev/null 2>&1
	if test $? -ne 0; then
		return 0
	fi
	PID=`ParentPid $$`
	SSHD_PIDS=`pidof sshd`
	while test "$PID" -ne 1; do
		for i in $SSHD_PIDS; do
			if test "$i" -eq "$PID"; then
				return 0
			fi
		done
		PID=`ParentPid ${PID}`
	done
	return 1
}

USER_COLOR=${blue}
HOST_COLOR=${white}
LAST_CHAR="$"

if IsRemoteLogin; then
	HOST_COLOR=${magenta}
fi

if test "$UID" = "0"; then
	USER_COLOR=${red}
	LAST_CHAR="#"
fi

function battery {
    test ! -d /sys/class/power_supply/BAT0 && return
    PERC=$(( $(cat /sys/class/power_supply/BAT0/charge_now) * 100 / $(cat /sys/class/power_supply/BAT0/charge_full) ))
    COLOR=$black
    test $PERC -lt 9 && COLOR=$yellow
    test $PERC -lt 6 && COLOR=$magenta
    test $PERC -lt 3 && COLOR=$RED
    DIRECTION=↑
    test "$(cat /sys/class/power_supply/BAT0/status)" = Discharging && DIRECTION=↓
    echo "${COLOR}${PERC}%%${DIRECTION}${NC}"
}

# prompt
setopt PROMPT_SUBST
PROMPT="$USER_COLOR%n$HOST_COLOR@%m$NC:%~$LAST_CHAR "
RPROMPT='$(battery)'

# convenience function for cloning score projects
CloneScore() {
    git clone https://github.com/score-framework/$1
    cd $1
    git remote set-url --push origin git@github.com:score-framework/$1.git
}

# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.history
HISTSIZE=11000
SAVEHIST=10000
setopt extendedglob
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall

# completion
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' expand suffix
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' menu select=3
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/home/soulmerge/.zshrc'

autoload -Uz compinit
compinit

export NVM_DIR="/home/soulmerge/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

