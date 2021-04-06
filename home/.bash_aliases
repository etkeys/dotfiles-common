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

    if which snap > /dev/null && snap list | grep -q '^code ' ; then
        alias c="code -r" #Execute vscode using a current instance
        alias cn="code -n" #Execture vscode using a new instance
    fi

# commands    
    alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
    alias airplane-mode.off="~/bin/airplane-mode off"
    alias airplane-mode.on="~/bin/airplane-mode on"
    alias caja.here="xdg-open . &"
    alias fopen="fopen.sh"
    alias lsblk='lsblk -e7 -o NAME,MAJ:MIN,SIZE,RO,TYPE,MOUNTPOINT,FSTYPE'
    alias lvmdiskscan='lvmdiskscan | sed "\;/dev/loop;d"'
    alias mount='mount -v'
    alias please='sudo "$BASH" -c "$(history -p !!)"'
    alias py='python3'
    alias snapr='snap run'
    alias sqquickemu='quickemu --status-quo'
    alias sysd='systemctl'
    # alias vmdrive.start="sudo /home/erik/repos/scripts/vmdrive.start"
    # alias vmdrive.stop="sudo /home/erik/repos/scripts/vmdrive.stop"
    alias vmdrive.start="sudo /home/erik/repos/scripts/npdisksetup.py -f /home/erik/.config/npdisksetup/setupcfg.yml start vmdrive"
    alias vmdrive.stop="sudo /home/erik/repos/scripts/npdisksetup.py -f /home/erik/.config/npdisksetup/setupcfg.yml stop vmdrive"
    alias umount='umount -v'
