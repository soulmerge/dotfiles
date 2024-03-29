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

# if enabled, EQUALS would replace words starting with an equals character
# with the full path to the command (i.e. `cat =python` is equivalent to
# `cat $(which python)`). Do not want this feature on gentoo, as it is a
# nuisance when installing a specific version of a package
# (emerge =app-shells/zsh-5.2)
unsetopt EQUALS

# virtualenvwrapper
test -f /usr/bin/virtualenvwrapper.sh && source /usr/bin/virtualenvwrapper.sh
test -f /usr/share/virtualenvwrapper/virtualenvwrapper.sh && source /usr/share/virtualenvwrapper/virtualenvwrapper.sh

# stderred
if test -f /usr/local/lib/libstderred.so; then
    alias stderredon='export LD_PRELOAD="$LD_PRELOAD /usr/local/lib/libstderred.so"'
    alias stderredoff='export LD_PRELOAD="$(echo ${LD_PRELOAD/\/usr\/local\/lib\/libstderred.so/}|sed s/\^\ //)"'
    stderredon
else
    alias stderredon="echo stderred not found"
    alias stderredoff="echo stderred not found"
fi

# some apps won't will issue warnings with LD_PRELOAD
alias offlineimap="LD_PRELOAD= offlineimap"
alias firefox="LD_PRELOAD= firefox"
alias thunderbird="LD_PRELOAD= thunderbird"
alias wine="LD_PRELOAD= wine"
alias winetricks="LD_PRELOAD= winetricks"
alias skype="LD_PRELOAD= skype"

# switching away from ack
alias ack="echo 'Use ag!' >&2; sleep 1; ag"

# environment variables
PATH=~/.npm/global-root/bin:~/bin/:$PATH:/usr/local/wheelbin:/usr/games/bin/:/usr/sbin:/sbin:~/.npm-global/bin:/snap/bin:/opt/bin:
export PATH
export INPUTRC=$HOME/.inputrc
export EDITOR=vim
export MANPAGER="/usr/bin/less -isr"
export TZ="Europe/Vienna"
export LESS="--ignore-case --chop-long-lines --RAW-CONTROL-CHARS"
export TIMEFMT=$'real\t%E\nuser\t%U\nsys\t%S'
export PAGER="less"

# aliases
alias ls="ls --color=tty"
alias cp='cp -i'
alias mv='mv -i'
alias grep='grep --exclude-dir=.svn --color=auto'
alias load='score projects load'

# common typos
alias sl="ls"
alias cim="vim"
alias vmi="vim"
alias vim.="vim ."


# set locale
if locale -a | grep -q en_DK; then
    export LANG=en_DK.utf-8
    export LANGUAGE=en_DK.utf-8
fi

# big xterm for presentations
alias bigxterm='xterm -font -*-fixed-medium-r-*-*-20-*-*-*-*-*-iso8859-* -geometry 70x24'

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

USER_COLOR=${green}
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
    COLOR=$BLUE
    test $PERC -lt 9 && COLOR=$yellow
    test $PERC -lt 6 && COLOR=$magenta
    test $PERC -lt 3 && COLOR=$RED
    DIRECTION=↑
    test "$(cat /sys/class/power_supply/BAT0/status)" = Discharging && DIRECTION=↓
    test $PERC -gt 98 && return
    echo " ${COLOR}${PERC}%%${DIRECTION}${NC}"
}

function prompt_date {
    echo "${blue}$(date '+%T')${NC}"
}

# prompt
setopt PROMPT_SUBST
PROMPT="$USER_COLOR%n$HOST_COLOR@%m$NC:%~$LAST_CHAR "
RPROMPT='$(prompt_date)$(battery)'

# re-render prompt on enter
# https://stackoverflow.com/a/33328293/44562
reset-prompt-and-accept-line() {
    zle reset-prompt
    zle accept-line
}
zle -N reset-prompt-and-accept-line
bindkey '^m' reset-prompt-and-accept-line

# convenience function for cloning score projects
CloneScore() {
    git clone git@github.com:score-framework/$1.git
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
zstyle ':completion:*' completer _expand _complete _ignored _correct
zstyle ':completion:*' expand suffix
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' menu select=3
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# Use ipdb for python breakpoints
export PYTHONBREAKPOINT=ipdb.set_trace

# browserstack authentication
[ -f ~/.browserstackrc ] && source ~/.browserstackrc

# The next block was inserted by the `cli' module of
# The SCORE Framework (http://score-framework.org)

    # The following line makes sure that you can access the `score'
    # application in your shell:
    PATH=$PATH:$HOME/.local/bin

# The next block was inserted by the `projects' module of
# The SCORE Framework (http://score-framework.org)

    # This next line updates your shell prompt to include the name of
    # the current project.
    if [ -n "$VIRTUAL_ENV_NAME" ]; then
        export PROMPT="%{[0;33m%}(${VIRTUAL_ENV_NAME})%{[0m%}$PROMPT"
    elif [ -n "$VIRTUAL_ENV" ]; then
        export PROMPT="%{[0;33m%}(${VIRTUAL_ENV##*/})%{[0m%}$PROMPT"
    fi

preexec() {
    export _PREVCMD_START_DATE=$(date "+%Y-%m-%d")
    export _PREVCMD_START=$(date "+%H:%M:%S")
    export _PREVCMD_START_TS=$(date "+%s")
    export _PREVCMD_COMMAND=$1
    export _PREVCMD_CWD=$(pwd)
}

precmd() {
    RESULT=$?
    if [ -n "$_PREVCMD_START_TS" -a -n "$_PREVCMD_COMMAND" ]; then
        ts_diff=$(( $(date "+%s") - $_PREVCMD_START_TS ))
        echo "$_PREVCMD_START $_PREVCMD_CWD# $_PREVCMD_COMMAND -> $RESULT in ${ts_diff}s" >> ~/.shell-history/$_PREVCMD_START_DATE.log
    fi
}

_git_delete_obsolete_branches() {
    git fetch --prune

    BRANCHES=$(git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}')

    echo Branches that are gone on origin:
    echo $BRANCHES | tr " " "\n"

    echo -n "Delete these branches (y/n)? "
    read -k answer
    echo

    if [ "$answer" != "y" ]; then echo aborting && return; fi

    echo $BRANCHES | xargs -n 1 git branch -D
}

# Initialize miniconda
source ~/.miniconda/etc/profile.d/conda.sh

# auto-activate allezam environment
conda env list | grep -qE '^allezam\s+' && conda activate allezam

export PYTHONBREAKPOINT=ipdb.set_trace

alias vim=nvim
