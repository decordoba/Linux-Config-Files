# ~/.bashrc: executed by bash(1) for non-login shells.

# if not running interactively, don't do anything. 
# In general, this prevents executing .bashrc in remote shells
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# ignore some commands (used really often) from history: bg, fg, ll, ls, exit
export HISTIGNORE="&:bg:fg:ll:ls:lh:la:lll:l:exit:clear:clr:pwd:p"

# setting history length.
# At most HISTSIZE history lines are stored from current session.
# HISTFILESIZE lines are remembered when we end the session: HISTSIZE
# from last session, plus HISTSIZE from the previous one, etc.
HISTSIZE=10000
HISTFILESIZE=20000

# append to the history file, don't overwrite it
shopt -s histappend

# Save all lines of multiline cmd in same history line
shopt -s cmdhist

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files, directories and subdirectories. Acts like * but
# also matches subdirectories
shopt -s globstar
#shopt -s extglob
#shopt -s dotglob
#shopt -s nullglob

# Minor errors in path spelling are corrected automatically
# i.e. 'cd ~/Desltop' will bring us to ~/Desktop
shopt -s cdspell

# make vi the default editor
set -o vi

# must press Ctrl+D 2+1 times to exit shell. Prevents closing shell by accident
export IGNOREEOF='2'

# make less more friendly for non-text input files, like gzip, bzip2, tgz...
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# ignore case in searches, long prompt, exit if text fits screen, allow colors ls and grep
export LESS="-iMFXR"

# set variable identifying the chroot you work in (used in the prompt below)
# will only be set if we are in a chrooted debian system inside our system
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set xterm to xterm-256color unless we are ssh-ing
if [ -n "$DISPLAY" ]; then
    export TERM=xterm-256color
fi

# set a fancy color prompt (non-color, unless we "want" color).
# Checks if $TERM is xterm-color, xterm-256color or xterm-16color,
# and if so, sets color_prompt to yes. See $TERM running 'env | grep TERM'
case "$TERM" in
    xterm-color|*-256color|*-16color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability
#force_color_prompt=yes

# if force_color_prompt is yes and the system can, color will be shown
if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

# show color  on prompt or not depending on the color_prompt variable
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
    xterm*|rxvt*) PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1";;
    *);;
esac

# enable color support of ls and also add handy aliases.
# Works only if /usr/bin/dircolors exists and is executable
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'  # same as ls
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some ls aliases (including tyos)
alias la='ls -Ah'  # do not ignore entries starting with .
alias ll='ls -Alh'  # same + long listing format + size in h format (K, M, G)
alias lh='ls -lh'  # see files in long format, ignoring files starting with .
alias l='ls'  # ls typo
alias s='ls'  # ls typo
alias sl='ls'  # ls typo
alias lll='ll --color=always | less -R'  # ll for many files
alias lst='ls -tr'  # sort oldest first
alias lat='la -tr'  # sort oldest first
alias llt='ll -tr'  # sort oldest first
alias lht='lh -tr'  # sort oldest first
alias lt='l -tr'  # sort oldest first
alias lllt='ll -tr --color=always | less -R'  # sort oldest first
alias lsg='ll | grep /$'  # search in ls

# aliases to navigate faster
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# screen aliases. Create a screen with screen1/2/3 and return to it with s1/2/3.
# Reminder: to detach from screen: Ctrl + A, + D
alias s1='screen -dr s1'
alias s2='screen -dr s2'
alias s3='screen -dr s3'
alias screen1='screen -S s1'
alias screen2='screen -S s2'
alias screen3='screen -S s3'

# set mv and cp to be interactive: ask before overwritting
alias mv='mv -i'
alias cp='cp -i'

# other aliases
alias space='du * -csh | sort -hr | less'  # space of files and folders (not subfolders)
alias spacef='du -hS | sort -hr | less'  # space taken by every folder and subfolder
alias p='pwd'
alias bd='cd "$OLDPWD"'  # go to previous directory
alias p4='ping 4.2.2.2 -c 4'  # check if we have access to the internet
alias tmp='pushd $(mktemp -d)'  # create tmp dir (removed on boot) and cd into it
alias lines='wc -l'  # count lines file
alias words='wc -w'  # count words file
alias asdf='fortune'  # get a fun quote
alias wisdom='fortune | cowsay -f tux | lolcat'  # get a message by a wise being
alias clr="clear"
alias src="source $HOME/.bashrc"
alias start="xdg-open"  # run a file as if double clicked. Also opens file manager
alias click="start"  # run a file as if double clicked. Also opens file manager
alias fm="xdg-open 2>/dev/null ."  # open file manager for current folder
alias empty="find . -depth -type d -empty"  # show empty folders
alias server="start http://localhost:8000 && python -m SimpleHTTPServer"  # serve current folder in localhost:8000
alias getip="ifconfig | grep inet\ addr:"

# Add an "alert" alias for long running commands. It will show a pop-up informing
# that the task is over. Pretty cool!
# Use: 'sleep 10; alert' or 'python slow_script.py args; alert'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions. You may put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (no need to enable this, if it's
# already enabled in /etc/bash.bashrc and /etc/profile sources /etc/bash.bashrc).
# Allows auto-completion of shell using TAB key
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Tab completion ignores cases
bind 'set completion-ignore-case On'
# Show completion without double tab-ing if there are several options
bind 'set show-all-if-ambiguous On'

# make SSH automatically complete hostname (if it is in history or config)
if [ ! -f $HOME/.ssh/config ]; then
    touch config
fi
complete -o default -o nospace -W "$(/usr/bin/env ruby -ne 'puts $_.split(/[,\s]+/)[1..-1].reject{|host| host.match(/\*|\?/)} if $_.match(/^\s*Host\s+/);' < $HOME/.ssh/config)" scp sftp ssh

# some useful functions
# Use: 'extract my_file.zip'
extract () {  # extract any file into current folder
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1 ;;
      *.tar.gz)    tar xzf $1 ;;
      *.bz2)       bunzip2 $1 ;;
      *.rar)       rar x $1 ;;
      *.gz)        gunzip $1 ;;
      *.tar)       tar xf $1 ;;
      *.tbz2)      tar xjf $1 ;;
      *.tgz)       tar xzf $1 ;;
      *.zip)       unzip $1 ;;
      *.Z)         uncompress $1 ;;
      *.7z)        7z x $1 ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
#Use: 'repeat 10 cd ..'
repeat() {  # repeat n times command.
  local i max
  max=$1; shift;
  for ((i=1; i <= max ; i++)); do  # --> C-like syntax
    eval "$@";
  done
}
# Use: 'mkcd my_new_folder'
mkcd() {  # create a folder and cd into it with one cmd only
  if [ $# != 1 ]; then
    echo "Usage: mkcd <dir>"
  else
    mkdir -p $1 && cd $1
  fi
}
# Use: 'bu my_config_file.cfg'
bu () {  # create backup file 
  if [ $# -lt 1 ]; then
    echo "Usage: bu <file>             # create backup in current folder"
    echo "       bu <file> <anything>  # create backup in .backups folder"
  elif [ $# -lt 2 ]; then
    cp $1 `basename $1`_`date +%Y%m%d%H%M`.backup ;  # in same folder
  else
    cp $1 ~/.backup/`basename $1`_`date +%Y%m%d%H%M`.backup ;  # in .backups folder
  fi
}
# Use: 'calc \(3^2 + 4^2\)^0.5'  # sorry, parenthesis must be escaped
calc() {  # create a terminal calculator
    echo "$@" | bc -l
} 
# Use: 'google who am I?'
google() {  # search something in google (will open a browser)
  local old s
  old="$IFS"
  IFS='+'
  s="$*"
  IFS=$old
  start "http://www.google.com/search?q=$s"
}

# Use: 'remindme 10m OMG, the pizza!'
remindme() {  # show pop up with reminder after time
  sleep $1 && zenity --info --title Reminder --text "${*:2}  " 2> /dev/null &
}

# Use: 'addssh user@example.com ssh_alias' or 'addssh user@example.com'
addssh() {  # Add ssh user and host to ~/.ssh/config to toggle autocomplete
  local user hostname host found hostname_tmp user_tmp path_config host_line i
  user=${1%%@*}
  hostname=${1#*@}
  path_config=$HOME/.ssh/config
  found=0
  i=0
  while IFS='' read -r line ; do
    i=$((i + 1))
    if [[ $line == User\ * ]]; then
      user_tmp=${line#*User\ }
    elif [[ $line == HostName\ * ]]; then
      hostname_tmp=${line#*HostName\ }
    elif [[ $line == Host\ * ]]; then
      host_line=$i
    fi
    if [[ ! -z $hostname_tmp && ! -z $user_tmp ]]; then
      if [[ $hostname == $hostname_tmp && $user == $user_tmp ]]; then
        found=1
	break
      fi
      unset user_tmp hostname_tmp
    fi
  done < $path_config

  host="${hostname}->${user}"
  if [[ ! -z $2 ]]; then
    host="${2}"
  fi

  if [[ $found == 0 ]]; then
    echo >> $path_config
    echo "Host ${host}" >> $path_config
    echo "HostName ${hostname}" >> $path_config
    echo "User ${user}" >> $path_config
  else
    # replace host alias
    sed -i "${host_line}s/.*/Host ${host}/" $path_config
  fi
  echo "Host created with name ${host}"

  source $HOME/.bashrc
  ssh $1
}