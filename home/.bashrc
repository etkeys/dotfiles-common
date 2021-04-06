# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# vi mode!! <Esc>:
set -o vi

# Alias definitions.
# Some later things depend on aliases being in place
if [ -f "$HOME/.bash_aliases" ] ; then
    . ~/.bash_aliases
fi
if [ -f "$HOME/.bash_aliases.local" ] ; then
    . ~/.bash_aliases.local
fi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
HISTIGNORE="l:l[als]:fg:cd:exit"

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Needed to add git status to cli prompt
# get the current branch in git repo
parse_git_branch() {
    BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    if [ ! "${BRANCH}" == "" ]; then
        STAT=`parse_git_dirty`
        echo "(${STAT}${BRANCH})"
    else
        echo ""
    fi
}

dir_stack_indicator(){
    lineend="$1"

    dirCount=$(dirs | wc -l)
    if [ $dirCount != "1" ] ; then
        lineend="ds:$((dirCount - 1))$lineend"
    fi

    echo "$lineend"
}

# get current status of git repo
parse_git_dirty() {
    status=`git status 2>&1 | tee`
    dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
    untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
    ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
    newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
    renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
    deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
    bits=''
    if [ "${ahead}" == "0" ]; then
        bits="${bits}*"
    fi
    if [ "${newfile}" == "0" ]; then
        bits="${bits}A"
    fi
    if [ "${deleted}" == "0" ]; then
        bits="${bits}D"
    fi
    if [ "${dirty}" == "0" ]; then
        bits="${bits}M"
    fi
    if [ "${renamed}" == "0" ]; then
        bits="${bits}R"
    fi
    if [ "${untracked}" == "0" ]; then
        bits="${bits}U"
    fi
    if [ ! "${bits}" == "" ]; then
        echo "${bits} "
    else
        echo ""
    fi
}

build_ps1() {
    dchroot="\n${debian_chroot:+($debian_chroot)}"
    
    if [ "$EUID" -eq 0 ] ; then
        username="ROOT"
    fi
    if [ "$USER_PRIMARY_HOST_FLAG" != "0" ] ; then
        host='@\h'
    fi
    if [ -n "$username" ] || [ -n "$host" ] ; then
        context="[$username$host]"

        if [ "$username" = "ROOT" ] ; then
            context="\[$(tput setab 1)\]$context\[$(tput sgr0)\] "
        else
            context="\[$(tput bold)\]\[$(tput setaf 2)\]$context\[$(tput sgr0)\] "
        fi 
    fi
    
    if [ "$username" = "ROOT" ] ; then
        cwd="\[$(tput setaf 3)\]\w\[$(tput sgr0)\] "
        userInd='#'
    else
        cwd="\[$(tput bold)\]\[$(tput setaf 4)\]\w\[$(tput sgr0)\] "
        userInd='$'
    fi

    line2='`dir_stack_indicator`'"$userInd"
    gitinfo="\[$(tput bold)\]\[$(tput setaf 6)\]"'`parse_git_branch`'"\[$(tput sgr0)\] "

    printf "$dchroot$context$cwd$gitinfo\n$line2 "
}
if [ "$TERM" = "linux" ] ; then
    echo -en "\e]PC5656C9" # blue
fi
PS1=$(build_ps1)

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# start the ssh-agent
start_agent() {
    echo "Initializing new SSH agent..."
    # spawn ssh-agent
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add
}

if [ $USER_PRIMARY_HOST_FLAG ] ; then
    if [ -n "$DESKTOP_SESSION" ] ; then
        terminal-init-info.sh
    fi

    if [ -f "${SSH_ENV}" ]; then
         . "${SSH_ENV}" > /dev/null
         ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
            start_agent;
        }
    else
        start_agent;
    fi
    ssh-add $HOME/.ssh/keys_AgFoxte
fi

# some ease of use functions
giti(){
    for arg in "$@"; do
        echo "$arg" >> .gitignore
    done
}

mkcd(){
    mkdir -p "$1";cd "$_";
}

popd(){
    command popd "$@" > /dev/null
}

pushd(){
    command pushd "$@" > /dev/null
}


# added by travis gem
[ -f /home/erik/.travis/travis.sh ] && source /home/erik/.travis/travis.sh
