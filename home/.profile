# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# Set variable to know if this machine is a primary machine
if [ -f "$HOME/.primaryhost" ] ; then
    export USER_PRIMARY_HOST_FLAG=0
fi

if [ -n "$DESKTOP_SESSION" ] ; then
    export XDG_CONFIG_HOME="$HOME/.config"
fi

if [ $USER_PRIMARY_HOST_FLAG ] ; then

    export JAVA_HOME="/usr/lib/jvm/default-java"
    export QEMU_JET='qemu+ssh://erik@jet/system?keyfile=.ssh/keys_AgFoxte'
    export TERMINAL="urxvt"
    export VMDIR="/mnt/vmdrive/erik"
   
    if [ -n "$DESKTOP_SESSION" ] && [ "$DESKTOP_SESSION" = "i3" ] ; then 
       # setleds -D +num
        xset r rate 1000 10
        xset dpms 0 0 600
        xmodmap "$HOME/.Xmodmap"
    fi
fi

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export SSH_ENV="$HOME/.ssh/environment"

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
if [ -d "$HOME/repos/scripts" ] ; then
    PATH="$HOME/repos/scripts:$PATH"
fi
if [ -d "$HOME/source/repos/scripts-personal" ] ; then
    PATH="$HOME/source/repos/scripts-personal" 
fi
