# ls and grep and tree
    alias dirs='dirs -v'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias ls=" ls --color=auto --group-directories-first --time-style=+'%y%m%d %H:%M'"
    alias ll="ls -AlFh"
    alias la="ls -AF"
    alias l="ls -CF"
    alias tree=" tree --dirsfirst"
    alias treex="tree -I"

# editors
    alias v="vim"
    alias vr="vim -R"

# commands    
    alias airplane-mode.off="~/bin/airplane-mode off"
    alias airplane-mode.on="~/bin/airplane-mode on"
    alias lsblk='lsblk -e7 -o NAME,MAJ:MIN,SIZE,RO,TYPE,MOUNTPOINT,FSTYPE'
    alias lvmdiskscan='lvmdiskscan | sed "\;/dev/loop;d"'
    alias mount='mount -v'
    alias please='sudo "$BASH" -c "$(history -p !!)"'
    alias py='python3'
    alias snapr='snap run'
    alias sudo='sudo -E'
    alias sysd='systemctl'
    alias umount='umount -v'

if [ -f ~/.bash_aliases.local ]; then
    . ~/.bash_aliases.local
fi
