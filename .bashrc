# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything. 
# In general, this prevents executing .bashrc in remote shells
case $- in
    *i*) ;;
      *) return;;
esac

# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# Ignore some commands (used really often) from history: bg, fg, ll, ls, exit
export HISTIGNORE="&:bg:fg:ll:ls:lh:la:lll:l:exit:logout:clear:clr:pwd:p"

# Setting history length.
# At most HISTSIZE history lines are stored from current session.
# HISTFILESIZE lines are remembered when we end the session: HISTSIZE
# from last session, plus HISTSIZE from the previous one, etc.
HISTSIZE=10000
HISTFILESIZE=20000

# Append to the history file, don't overwrite it
shopt -s histappend

# Save all lines of multiline cmd in same history line
shopt -s cmdhist

# Check the window size after each command and, if necessary,
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

# Make vim the default editor
export EDITOR=vim  # Normally VISUAL will be called 1st, if it fails EDITOR will be
export VISUAL=vim  # Normally VISUAL will be called 1st, if it fails EDITOR will be
set -o vi

# Swap ESC and CAPS_LOCK keys. Crucial for changing modes in vim faster
/usr/bin/setxkbmap -option "caps:swapescape"

# Must press Ctrl+D 2+1 times to exit shell. Prevents closing shell by accident
export IGNOREEOF='2'

# Make less more friendly for non-text input files, like gzip, bzip2, tgz...
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Ignore case in searches, long prompt, exit if text fits screen, allow colors ls and grep
export LESS="-iMFXR"

# Set variable identifying the chroot you work in (used in the prompt below)
# will only be set if we are in a chrooted debian system inside our system
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Set XTERM to xterm-256color (colored prompt) unless we are ssh-ing
if [ -n "$DISPLAY" ]; then
    export TERM=xterm-256color
fi

# Set a fancy color prompt (non-color, unless we "want" color).
# Checks if $TERM is xterm-color, xterm-256color or xterm-16color,
# and if so, sets color_prompt to yes. See $TERM running 'env | grep TERM'
case "$TERM" in
    xterm-color|*-256color|*-16color) color_prompt=yes;;
esac

# Uncomment for a colored prompt, if the terminal has the capability
#force_color_prompt=yes

# If force_color_prompt is yes and the system can, color will be shown
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

# Format prompt as user@host:path$
# Show color on prompt or not depending on the color_prompt variable
# Create aliases to change between long prompt and short prompt.
# long shows full path, short shows only current sub-folder
if [ "$color_prompt" = yes ]; then
    # user@host are green(32m), path is light_blue(94m)
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;94m\]\w\[\033[00m\]\$ '
    alias ps1short="PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;94m\]\W\[\033[00m\]\$ '"
    alias ps1long="PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;94m\]\w\[\033[00m\]\$ '"
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    alias ps1short="PS1='${debian_chroot:+($debian_chroot)}\u@\h:\W\$ '"
    alias ps1long="PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '"
fi
unset color_prompt force_color_prompt
alias pathshort="ps1short"
alias pathlong="ps1long"

# If this is an xterm set the title to user@host:dir
case "$TERM" in
    xterm*|rxvt*) PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1";;
    *);;
esac

# Enable color support of ls and also add handy aliases.
# Works only if /usr/bin/dircolors exists and is executable
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'  # same as ls
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Some ls aliases (including typos)
# This looks messy, but it's pretty simple: 3 basic commands: ls (or l), ll, lll.
# ll does ls in long format (one file per line) and lll pipes ll to less.
# If we add an a to them (lsa (la), lla, llla), we include folders and files starting with .
# If we add a t to them (lst (lt), llt, lllt), files and folders are sorted by date, not alphabetically
# If we add a g to them (lsg (lg), llg, lllg), folders will be listed before files
# We can use 2 or 3 prefixes at the same time, in any order, like llag, lsta, lllgt, latg, etc.
alias l='ls'  # ls typo
alias ll='ls -lh'  # long listing format + size in human-readable format (K, M, G)
alias lll='ll --color=always | less -R'  # ll for many files (pipe into less)
alias lsa='ls -A'  # do not ignore entries starting with .
alias la='lsa'
alias lla='ll -A'
alias llla='lla --color=always | less -R'
alias lst='ls -tr'  # sort oldest first
alias lt='lst'
alias llt='ll -tr'
alias lllt='llt --color=always | less -R'
alias lsat='lsa -tr'
alias lsta='lsa -tr'
alias lat='la -tr'
alias lta='la -tr'
alias llat='lla -tr'
alias llta='lla -tr'
alias lllat='llat --color=always | less -R'
alias lllta='llta --color=always | less -R'
alias lsg='ls --group-directories-first'  # show folders first, then files
alias lg='lsg'
alias llg='ll --group-directories-first'
alias lllg='llg --color=always | less -R'
alias lsag='lsg -A'
alias lsga='lsg -A'
alias lag='lg -A'
alias lga='lg -A'
alias llag='llg -A'
alias llga='llg -A'
alias lllag='llag --color=always | less -R'
alias lllga='llga --color=always | less -R'
alias lstg='lsg -tr'
alias lsgt='lsg -tr'
alias ltg='lg -tr'
alias lgt='lg -tr'
alias lltg='llg -tr'
alias llgt='llg -tr'
alias llltg='lltg --color=always | less -R'
alias lllgt='llgt --color=always | less -R'
alias lstga='lstg -A'
alias ltga='ltg -A'
alias lltga='lltg -A'
alias llltga='lltga --color=always | less -R'
alias lstag='lstg -A'
alias ltag='ltg -A'
alias lltag='lltg -A'
alias llltag='lltga --color=always | less -R'
alias lsatg='lstg -A'
alias latg='ltg -A'
alias llatg='lltg -A'
alias lllatg='lltga --color=always | less -R'
alias lsagt='lstg -A'
alias lagt='ltg -A'
alias llagt='lltg -A'
alias lllagt='lltga --color=always | less -R'
alias lsgat='lstg -A'
alias lgat='ltg -A'
alias llgat='lltg -A'
alias lllgat='lltga --color=always | less -R'
alias lsgta='lstg -A'
alias lgta='ltg -A'
alias llgta='lltg -A'
alias lllgta='lltga --color=always | less -R'

# Aliases to navigate back faster
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# screen aliases. Create a screen with screen1/2/3 and return to it with s1/2/3.
alias s1='screen -dr s1'
alias s2='screen -dr s2'
alias s3='screen -dr s3'
alias screen1='screen -S s1'
alias screen2='screen -S s2'
alias screen3='screen -S s3'

# Set mv and cp to be interactive: ask before overwritting
alias mv='mv -i'
alias cp='cp -i'

# Other aliases
alias space='du -csh * .[!.]* 2>/dev/null | sort -hr | less'  # space of files and folders (not subfolders)
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
alias src="source $HOME/.bashrc"  # update source file
alias vsrc="vim $HOME/.bashrc"  # edit source file
alias bashrc="vsrc"
alias vimrc="vim $HOME/.vim/vimrc"  # edit vim source file
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

# Enable programmable completion features (no need to enable this, if it's
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
# Stop bell sound when autocomplete cannot find an answer
bind 'set bell-style none'

# Make SSH automatically complete hostname (if it is in history or config)
if [ ! -d $HOME/.ssh ]; then
  mkdir $HOME/.ssh
  touch $HOME/.ssh/config
elif [ ! -f $HOME/.ssh/config ]; then
  touch $HOME/.ssh/config
fi
# TODO: What if ruby does not exist!
complete -o default -o nospace -W "$(/usr/bin/env ruby -ne 'puts $_.split(/[,\s]+/)[1..-1].reject{|host| host.match(/\*|\?/)} if $_.match(/^\s*Host\s+/);' < $HOME/.ssh/config)" scp sftp ssh

# Some useful functions
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
    echo "Usage: mkcd dir"
  else
    mkdir -p $1 && cd $1
  fi
}
# Use: 'newest' or 'newest 3'
newest() {  # get newest folder, or Nth newest folder
  local idx re folders
  if [ $# -lt 1 ]; then
    idx=1
  else
    idx=$1
    re='^[0-9]+$'
    if ! [[ $idx =~ $re ]] || [[ $idx -lt 1 ]] ; then
      echo ""
      return
    fi
  fi
  # if current directory contains at least one folder
  if ! [[ "$(find . -maxdepth 0 -empty)" == "." ]] && ! [[ "$(find * -maxdepth 0 -type d)" == "" ]]; then
    echo "$(ls -trd */ | tail -n $idx | head -n 1)"
  else
    echo "."
  fi
}
# Use: 'oldest' or 'oldest 3'
oldest() {  # get oldest folder, or Nth oldest folder
  local idx re
  if [ $# -lt 1 ]; then
    idx=1
  else
    idx=$1
    re='^[0-9]+$'
    if ! [[ $idx =~ $re ]] || [[ $idx -lt 1 ]] ; then
      echo ""
      return
    fi
  fi
  # if current directory contains at least one folder
  if ! [[ "$(find . -maxdepth 0 -empty)" == "." ]] && ! [[ "$(find * -maxdepth 0 -type d)" == "" ]]; then
    echo "$(ls -trd */ | head -n $idx | tail -n 1)"
  else
    echo "."
  fi
}
# Use: 'cdn' or 'cdn 3'  # cdn for cd newest
cdn() {  # cd into newest folder, or cd into Nth newest folder
  local n
  n="$(newest $@)"
  if [[ $n == "" ]]; then
    echo "Usage: cdn      # cd into newest folder"
    echo "       cdn [N]  # cd into Nth newest folder (N should be number > 0)"
    return
  fi
  cd $n
}
# Use: 'cdo' or 'cdo 3'  # cdo for cd oldest
cdo() {  # cd into oldest folder, or cd into Nth oldest folder
  local n
  n="$(oldest $@)"
  if [[ $n == "" ]]; then
    echo "Usage: cdo      # cd into oldest folder"
    echo "       cdo [N]  # cd into Nth oldest folder (N should be number > 0)"
    return
  fi
  cd $n
}
# Use: 'rmn' or 'rmn 3'  # rmn for rm newest
rmn() {  # rm newest folder, or rm Nth newest folder
  local n
  n="$(newest $@)"
  if [[ $n == "" ]]; then
    echo "Usage: rmn      # rm newest folder"
    echo "       rmn [N]  # rm Nth newest folder (N should be number > 0)"
    return
  fi
  rm $n -r
}
# Use: 'rmo' or 'rmo 3'  # rmo for rm oldest
rmo() {  # rm oldest folder, or rm Nth oldest folder
  local n
  n="$(oldest $@)"
  if [[ $n == "" ]]; then
    echo "Usage: rmo      # rm oldest folder"
    echo "       rmo [N]  # rm Nth oldest folder (N should be number > 0)"
    return
  fi
  rm $n -r
}
# Use: 'lsn' or 'lsn 3'  # lsn for ls newest
lsn() {  # ls into newest folder, or ls into Nth newest folder
  local n
  n="$(newest $@)"
  if [[ $n == "" ]]; then
    echo "Usage: lsn      # ls into newest folder"
    echo "       lsn [N]  # ls into Nth newest folder (N should be number > 0)"
    return
  fi
  ls $n
}
# Use: 'lso' or 'lso 3'  # lso for ls oldest
lso() {  # ls into oldest folder, or ls into Nth oldest folder
  local n
  n="$(oldest $@)"
  if [[ $n == "" ]]; then
    echo "Usage: lso      # ls into oldest folder"
    echo "       lso [N]  # ls into Nth oldest folder (N should be number > 0)"
    return
  fi
  ls $n
}
# Use: 'lln' or 'lln 3'  # lln for ll newest
lln() {  # ll into newest folder, or ll into Nth newest folder
  local n
  n="$(newest $@)"
  if [[ $n == "" ]]; then
    echo "Usage: lln      # ll into newest folder"
    echo "       lln [N]  # ll into Nth newest folder (N should be number > 0)"
    return
  fi
  ll $n
}
# Use: 'llo' or 'llo 3'  # llo for ll oldest
llo() {  # ll into oldest folder, or ll into Nth oldest folder
  local n
  n="$(oldest $@)"
  if [[ $n == "" ]]; then
    echo "Usage: llo      # ll into oldest folder"
    echo "       llo [N]  # ll into Nth oldest folder (N should be number > 0)"
    return
  fi
  ll $n
}
# Use: 'llln' or 'llln 3'  # llln for lll newest
llln() {  # lll into newest folder, or lll into Nth newest folder
  local n
  n="$(newest $@)"
  if [[ $n == "" ]]; then
    echo "Usage: llln      # lll into newest folder"
    echo "       llln [N]  # lll into Nth newest folder (N should be number > 0)"
    return
  fi
  ll $n --color=always | less -R
}
# Use: 'llo' or 'llo 3'  # llo for ll oldest
lllo() {  # lll into oldest folder, or lll into Nth oldest folder
  local n
  n="$(oldest $@)"
  if [[ $n == "" ]]; then
    echo "Usage: lllo      # lll into oldest folder"
    echo "       lllo [N]  # lll into Nth oldest folder (N should be number > 0)"
    return
  fi
  ll $n --color=always | less -R
}
# Use: 'bu my_config_file.cfg'
bu () {  # create backup file 
  if [ $# -lt 1 ]; then
    echo "Usage: bu file             # create backup in current folder"
    echo "       bu file [anything]  # create backup in .backups folder"
  elif [ $# -lt 2 ]; then
    cp $1 `basename $1`_`date +%Y%m%d%H%M`.backup ;  # in same folder
  else
    cp $1 ~/.backup/`basename $1`_`date +%Y%m%d%H%M`.backup ;  # in .backups folder
  fi
}
# Use: 'calc \(3^2 + 4^2\)^0.5'  # sorry, parenthesis must be escaped, unless formula is surrounded by ""
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
  sleep $1 && notify-send --urgency=normal -i face-monkey "Reminder:   ${*:2}" -t 30000 && zenity --info --title Reminder --text "${*:2}  " 2> /dev/null &
}

# Use: 'addssh user@example.com ssh_alias' or 'addssh user@example.com'
addssh() {  # Add ssh user and host to ~/.ssh/config to toggle autocomplete
  local user hostname host found hostname_tmp user_tmp path_config host_line i
  if [ $# -lt 1 ]; then
    echo "Usage: add user@hostname              # add SSH user and hostname to .ssh/config. SSH alias is assigned automatically (recommended)"
    echo "       add user@hostname [ssh_alias]  # add SSH user and hostname to .ssh/confid, and use SSH alias to access it"
    return
  fi
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

  host="${hostname}---${user}"
  if [[ ! -z $2 ]]; then
    host="${2}"
  fi

  if [[ $found == 0 ]]; then
    echo "Host ${host}" >> $path_config
    echo "HostName ${hostname}" >> $path_config
    echo "User ${user}" >> $path_config
    echo >> $path_config
  else
    # replace host alias
    sed -i "${host_line}s/.*/Host ${host}/" $path_config
  fi
  echo "Host created with name ${host}"

  source $HOME/.bashrc
  ssh $1
}
