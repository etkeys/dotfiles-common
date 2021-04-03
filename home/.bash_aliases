# ls and grep and tree
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias ls=" ls --color=auto --group-directories-first --time-style=+'%y%m%d %H:%M'"
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'
    alias ll="ls -AlFh"
    alias la="ls -AF"
    alias l="ls -CF"
    alias tree=" tree --dirsfirst"
    alias treex="tree -I"

# editors
    alias v="vim"

    if [ $USER_PRIMARY_HOST_FLAG ] ; then
        alias c="code -r" #Execute vscode using a current instance
        alias cn="code" #Execture vscode using a new instance
        alias eclipse.run.java="$HOME/bin/eclipse/java/eclipse &"
    fi

# commands    
    alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
    alias airplane-mode.off="~/bin/airplane-mode off"
    alias airplane-mode.on="~/bin/airplane-mode on"
    alias caja.here="xdg-open . &"
    alias fopen="$HOME/bin/fopen.sh"
    alias lampp.run="sudo /opt/lampp/manager-linux-x64.run"
    alias please='sudo "$BASH" -c "$(history -p !!)"'
    alias py='python3'
    alias tsd="terminal-samedir"
    alias vmdrive.start="sudo ~/bin/vmdrive/vmdrive.start"
    alias vmdrive.stop="sudo ~/bin/vmdrive/vmdrive.stop"
