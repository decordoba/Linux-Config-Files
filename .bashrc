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

# Interprets [a-d] as [abcd]. To match a literal -, include it as 1st or last char
shopt -s globasciiranges

# The pattern "**" used in a pathname expansion context will match all files,
# directories and subdirectories. Acts like * but also matches subdirectories.
# Example use: 'ls **' (instead of 'ls *') shows all directories and subdirectories
shopt -s globstar

# Composite patterns may be formed using  one  or  more  of  the sub-patterns:
# ?(pattern-list) = Matches zero or one occurrence of the given patterns
# *(pattern-list) = Matches zero or more occurrences of the given patterns
# +(pattern-list) = Matches one or more occurrences of the given patterns
# @(pattern-list) = Matches one of the given patterns
# !(pattern-list) = Matches anything except one of the given patterns
# Example: 'ls +(ab|def)*+(.jpg|.gif)' shows all JPG and GIF files starting with ab and def
# Example: 'ls ?????*.[ch]' shows all .c and .h files with at least 5 chars in their name
# Example: 'ls !(*.jpg|*.gif)' shows all files except JPG and GIF files
shopt -s extglob

# Uncomment to include dotfiles when matching globs
#shopt -s dotglob
# Uncomment to expand non-matching globs to zero arguments instead of to themselves
#shopt -s nullglob

# Minor errors in path spelling are corrected automatically
# i.e. 'cd ~/Desltop' will bring us to ~/Desktop
shopt -s cdspell

# A command name that is the name of a directory is executed as if it were the argument to the cd command
# Type a folder name to cd automatically to it, no need to write cd before it
shopt -s autocd  # warning! new directory will not be saved to cd history if used

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

# Set XTERM to xterm-256color (colored prompt, highly recommended)
# Comment this to use your system's default prompt
export TERM=xterm-256color

# Set a fancy color prompt (non-color, unless we "want" color).
# Checks if $TERM is xterm-color, xterm-256color or xterm-16color,
# and if so, sets color_prompt to yes. See $TERM running 'env | grep TERM'
case "$TERM" in
  xterm-color|*-256color|*-16color) color_prompt=yes;;
esac

# Format prompt as user@host:path$
# Show color on prompt or not depending on the color_prompt variable
# Create aliases to change between long prompt, short prompt and two lines prompt
# long shows full path, short shows only current sub-folder, line adds new line after path
if [ "$color_prompt" = yes ]; then
  # user@host are green(32m), path is light_blue(94m)
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;94m\]\w\[\033[00m\]\$ '
  alias ps1short="PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;94m\]\W\[\033[00m\]\$ '"
  alias ps1long="PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;94m\]\w\[\033[00m\]\$ '"
  alias ps1line="PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;94m\]\w\[\033[00m\]\n\$ '"
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
  alias ps1short="PS1='${debian_chroot:+($debian_chroot)}\u@\h:\W\$ '"
  alias ps1long="PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '"
  alias ps1line="PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\n\$ '"
fi
unset color_prompt
alias pathshort="ps1short"
alias pathlong="ps1long"
alias pathline="ps1line"

# If this is an xterm set the title (the text on top of the terminal window) to user@host:dir
case "$TERM" in
  xterm*|rxvt*) PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1";;
  *);;
esac

# Enable color support of ls and also add handy aliases.
# Works only if /usr/bin/dircolors exists and is executable
if [ -x /usr/bin/dircolors ]; then
  test -r $HOME/.dircolors && eval "$(dircolors -b $HOME/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'  # same as ls
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# Make sure links are painted cyan, which is not the default in the trapd00r/LS_COLORS repo
# In some monitors the blue used for folders is too dark and hard to read, change it to light_blue
# Paint python files in green bold, and .pyc files in gray
LS_COLORS=$LS_COLORS'ln=1;36:'
LS_COLORS=$LS_COLORS'di=1;94:'
LS_COLORS=$LS_COLORS'*.py=38;5;41:'
LS_COLORS=$LS_COLORS'*.pyc=38;5;240:'
export LS_COLORS

# Colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Some ls aliases (including typos)
# This looks messy, but it's pretty simple: 3 basic commands: ls (or l), ll, lll.
# ll does ls in long format (one file per line) and lll pipes ll to less.
# If we add an a to them (lsa (la), lla, llla), we include folders and files starting with a dot (.)
# If we add a t to them (lst (lt), llt, lllt), files and folders are sorted by date, not alphabetically
# If we add a g to them (lsg (lg), llg, lllg), folders will be listed before files
# We can use 2 or 3 suffixes at the same time, in any order, like llag, lsta, lllgt, latg, etc.
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
alias cd..='cd ..'
alias ~="cd ~"  # `cd` is probably faster to type though
alias -- -='cd -'  # go to previous directory
alias bd='cd "$OLDPWD"'  # go to previous directory (like cd -)
alias cd='cd_func'  # allow to do cd -N to cd to folder in history
alias -- --='cd --'  # show cd history
alias -- -1='cd -1'  # cd to 1st most recently visited folder
alias -- -2='cd -2'  # cd to 2nd most recently visited folder
alias -- -3='cd -3'  # cd to 3rd most recently visited folder
alias -- -4='cd -4'  # cd to 4th most recently visited folder
alias -- -5='cd -5'  # cd to 5th most recently visited folder
alias -- -6='cd -6'  # cd to 6th most recently visited folder
alias -- -7='cd -7'  # cd to 7th most recently visited folder
alias -- -8='cd -8'  # cd to 8th most recently visited folder
alias -- -9='cd -9'  # cd to 9th most recently visited folder
alias -- -10='cd -10'  # cd to 10th most recently visited folder

# Screen aliases. Create a screen with screen1/2/3/4 and return to it with s1/2/3/4
alias s1='screen -dr s1'
alias s2='screen -dr s2'
alias s3='screen -dr s3'
alias s4='screen -dr s4'
alias screen1='screen -S s1'
alias screen2='screen -S s2'
alias screen3='screen -S s3'
alias screen4='screen -S s4'

# Set mv and cp to be interactive: ask before overwritting
alias mv='mv -i'
alias cp='cp -i'

# Fast navigation aliases
alias cdDc='cd $HOME/Documents'
alias cdDw='cd $HOME/Downloads'
alias cdDe='cd $HOME/Desktop'
alias cdD=cdDc
alias cdM='cd $HOME/Music'
alias cdV='cd $HOME/Videos'
alias cdP='cd $HOME/Pictures'
alias cdL='cd $HOME/Documents/Linux-Config-Files'

# Other aliases
alias space='du -csh * .[!.]* 2>/dev/null | sort -hr | less'  # space of files and folders (not subfolders)
alias spacef='du -hS | sort -hr | less'  # space taken by every folder and subfolder
alias p='pwd'
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
alias empty="find . -depth -type d -empty"  # show empty folders. Run empty -delete to delete those folders
alias emptyrm="echo Removing folders: && empty && empty -delete"  # remove empty folders
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
# Use: 'cpcd my_old_location my_new_location_where_I_will_cd'
cpcd () {  # copy a file or folder and cd into the destination directory
  cp "$@"
  if [ $? -eq 0 ]; then
    if [ -d "$2" ];then
      cd $2
    else
      cd $(dirname $2)
    fi
  fi
}
# Use: 'mvcd my_old_location my_new_location_where_I_will_cd'
mvcd () {  # move a file or folder and cd into the destination directory
  mv "$@"
  if [ $? -eq 0 ]; then
    if [ -d "$2" ];then
      cd $2
    else
      cd $(dirname $2)
    fi
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
    return 1
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
    return 1
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
    return 1
  fi
  echo "Removed folder: $n"
  rm $n -r
}
# Use: 'rmo' or 'rmo 3'  # rmo for rm oldest
rmo() {  # rm oldest folder, or rm Nth oldest folder
  local n
  n="$(oldest $@)"
  if [[ $n == "" ]]; then
    echo "Usage: rmo      # rm oldest folder"
    echo "       rmo [N]  # rm Nth oldest folder (N should be number > 0)"
    return 1
  fi
  echo "Removed folder: $n"
  rm $n -r
}
# Use: 'lsn' or 'lsn 3'  # lsn for ls newest
lsn() {  # ls into newest folder, or ls into Nth newest folder
  local n
  n="$(newest $@)"
  if [[ $n == "" ]]; then
    echo "Usage: lsn      # ls into newest folder"
    echo "       lsn [N]  # ls into Nth newest folder (N should be number > 0)"
    return 1
  fi
  echo "Folder: $n"
  ls $n
}
# Use: 'lso' or 'lso 3'  # lso for ls oldest
lso() {  # ls into oldest folder, or ls into Nth oldest folder
  local n
  n="$(oldest $@)"
  if [[ $n == "" ]]; then
    echo "Usage: lso      # ls into oldest folder"
    echo "       lso [N]  # ls into Nth oldest folder (N should be number > 0)"
    return 1
  fi
  echo "Folder: $n"
  ls $n
}
# Use: 'lln' or 'lln 3'  # lln for ll newest
lln() {  # ll into newest folder, or ll into Nth newest folder
  local n
  n="$(newest $@)"
  if [[ $n == "" ]]; then
    echo "Usage: lln      # ll into newest folder"
    echo "       lln [N]  # ll into Nth newest folder (N should be number > 0)"
    return 1
  fi
  echo "Folder: $n"
  ll $n
}
# Use: 'llo' or 'llo 3'  # llo for ll oldest
llo() {  # ll into oldest folder, or ll into Nth oldest folder
  local n
  n="$(oldest $@)"
  if [[ $n == "" ]]; then
    echo "Usage: llo      # ll into oldest folder"
    echo "       llo [N]  # ll into Nth oldest folder (N should be number > 0)"
    return 1
  fi
  echo "Folder: $n"
  ll $n
}
# Use: 'llln' or 'llln 3'  # llln for lll newest
llln() {  # lll into newest folder, or lll into Nth newest folder
  local n
  n="$(newest $@)"
  if [[ $n == "" ]]; then
    echo "Usage: llln      # lll into newest folder"
    echo "       llln [N]  # lll into Nth newest folder (N should be number > 0)"
    return 1
  fi
  echo "Folder: $n"
  ll $n --color=always | less -R
}
# Use: 'llo' or 'llo 3'  # llo for ll oldest
lllo() {  # lll into oldest folder, or lll into Nth oldest folder
  local n
  n="$(oldest $@)"
  if [[ $n == "" ]]; then
    echo "Usage: lllo      # lll into oldest folder"
    echo "       lllo [N]  # lll into Nth oldest folder (N should be number > 0)"
    return 1
  fi
  echo "Folder: $n"
  ll $n --color=always | less -R
}
# Use: 'cpn' or 'cpn 3'  # cpn for cp newest
cpn() {  # cp newest folder, or cp Nth newest folder
  local n re args
  re='^[0-9]+$'
  if ! [[ $1 =~ $re ]] ; then
    n="$(newest)"
    args="$@"
  else
    n="$(newest $1)"
    args="${@:2}"
  fi
  if [[ $n == "" ]] || [[ $args == "" ]] ; then
    echo "Usage:   cpn location      # cp newest folder into location"
    echo "         cpn [N] location  # cp Nth newest folder into location (N should be number > 0)"
    echo "Warning: if location is a number, the argument N is mandatory."
    return 1
  fi
  echo "Running: cp $n $args -r"
  cp $n $args -r
}
# Use: 'cpo' or 'cpo 3'  # cpo for cp oldest
cpo() {  # cp oldest folder, or cp Nth oldest folder
  local n re args
  re='^[0-9]+$'
  if ! [[ $1 =~ $re ]] ; then
    n="$(oldest)"
    args="$@"
  else
    n="$(oldest $1)"
    args="${@:2}"
  fi
  if [[ $n == "" ]] || [[ $args == "" ]] ; then
    echo "Usage:   cpo location      # cp oldest folder into location"
    echo "         cpo [N] location  # cp Nth oldest folder into location (N should be number > 0)"
    echo "Warning: if location is a number, the argument N is mandatory."
    return 1
  fi
  echo "Running: cp $n $args -r"
  cp $n $args -r
}
# Use: 'mvn' or 'mvn 3'  # mvn for mv newest
mvn() {  # mv newest folder, or mv Nth newest folder
  local n re args
  re='^[0-9]+$'
  if ! [[ $1 =~ $re ]] ; then
    n="$(newest)"
    args="$@"
  else
    n="$(newest $1)"
    args="${@:2}"
  fi
  if [[ $n == "" ]] || [[ $args == "" ]] ; then
    echo "Usage:   mvn location      # mv newest folder into location"
    echo "         mvn [N] location  # mv Nth newest folder into location (N should be number > 0)"
    echo "Warning: if location is a number, the argument N is mandatory."
    return 1
  fi
  echo "Running: mv $n $args"
  mv $n $args
}
# Use: 'mvo' or 'mvo 3'  # mvo for mv oldest
mvo() {  # mv oldest folder, or mv Nth oldest folder
  local n re args
  re='^[0-9]+$'
  if ! [[ $1 =~ $re ]] ; then
    n="$(oldest)"
    args="$@"
  else
    n="$(oldest $1)"
    args="${@:2}"
  fi
  if [[ $n == "" ]] || [[ $args == "" ]] ; then
    echo "Usage:   mvo location      # mv oldest folder into location"
    echo "         mvo [N] location  # mv Nth oldest folder into location (N should be number > 0)"
    echo "Warning: if location is a number, the argument N is mandatory."
    return 1
  fi
  echo "Running: mv $n $args"
  mv $n $args
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

# Use: 'clock'
clock () {  # show a real time bash clock in the terminal
  local clockstr
  while true; do
    clockstr="============\n| $(date +%T) |\n============\n";
    clear;
    printf "$clockstr";
    sleep 1;
  done
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
    return 1
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

# Make accessible or inaccessible (encrypted) an encrypted hard drive partition
# The device should have been previously encrypted with cryptsetup
# See: https://askubuntu.com/questions/500981/how-to-encrypt-external-devices
# It is assumed that there is a /$hdd_name folder, if it doesn't exist the device won't be mounted
# Use: 'hddunlock' or 'hddunlock /dev/sdb1' or 'hddunlock /dev/sdb1 folder_name'
default_hdd_name='data'
default_device='/dev/sdc1'
hddunlock() {
  if [ $# -lt 1 ]; then
    device=default_device
  else
    device=$1
  fi
  if [ $# -lt 2 ]; then
    hdd_name=default_hdd_name
  else
    hdd_name=$2
  fi
  folder=/$hdd_name
  hdd_name=${hdd_name//\//_}
  if [ ! -d $folder ]; then
    echo The folder $folder does not exist. Create it to mount $device there.
    return 1
  fi
  echo Unlocking device $device, naming it $hdd_name...
  sudo cryptsetup luksOpen $device $hdd_name
  if [ $? -ne 0 ]; then
    echo Failed to unlock $device.
    return 1
  fi
  echo Mounting $device to folder $folder...
  sudo mount /dev/mapper/$hdd_name $folder
  if [ $? -ne 0 ]; then
    echo Failed to mount folder $folder. Re-locking device $device.
    # relock device if there was any error
    sudo cryptsetup luksClose $hdd_name
    if [ $? -ne 0 ]; then
      echo Failed to re-lock $device.
      return 1
    fi
    echo Re-locked!
    return 1
  fi
  echo Unlocked!
}
# Use: 'hddlock' or 'hddlock folder_name' (expects a folder unlocked with hddunlock)
hddlock() {
  if [ $# -lt 1 ]; then
    hdd_name=default_hdd_name
  else
    hdd_name=$1
  fi
  folder=/$hdd_name
  hdd_name=${hdd_name//\//_}
  echo Unmounting $folder...
  sudo umount $folder
  if [ $? -ne 0 ]; then
    echo Failed to mount $folder. Make sure no terminal or file manager are inside $folder.
    return 1
  fi
  echo Locking $hdd_name...
  sudo cryptsetup luksClose $hdd_name
  if [ $? -ne 0 ]; then
    echo Failed to lock $hdd_name. Lock it manually running: 'sudo cryptsetup luksClose (TAB)'
    return 1
  fi
  echo Locked!
}

# Use: 'cd_func --' or 'cd_func -3' or 'cd_func my_folder'. Can be safely aliased as cd
cd_func () {  # Navigate to folders in history with cd_func -3 (3rd most recent folder), or see history with cd_func --
  local new_dir n  # strings
  local -i i  # integers
  # print numbered directories history if 'cd --'
  if [[ $1 ==  "--" ]]; then
    dirs -v
    return 0
  fi
  # save the first argument, if $1 is null or empty save $HOME
  new_dir=$1
  [[ -z $1 ]] && new_dir=$HOME
  # if 'cd -N', extract Nth most recent directory from dirs history
  if [[ ${new_dir:0:1} == '-' ]]; then
    n=${new_dir:1}
    [[ -z $n ]] && n=1
    n=$(dirs +$n)  # returns nth element in dirs and prints it
    [[ -z $n ]] && return 1
    new_dir=$n
  fi
  # substitute '~' by ${HOME} (necessary to remove old occurrences)
  [[ ${new_dir:0:1} == '~' ]] && new_dir="${HOME}${new_dir:1}"
  # change to new_dir and add it to the top of the stack
  pushd "${new_dir}" > /dev/null  # adds new_dir to dirs and navigates there
  [[ $? -ne 0 ]] && return 1
  new_dir=$(pwd)
  # remove any other occurrence of this dir, skipping the top of the stack
  for ((i=1; i<=10; i++)); do
    n=$(dirs +${i} 2>/dev/null)
    [[ $? -ne 0 ]] && continue
    [[ ${n:0:1} == '~' ]] && n="${HOME}${n:1}"
    if [[ "${n}" == "${new_dir}" ]]; then
      popd -n +$i 2>/dev/null 1>/dev/null
      i=i-1
    fi
  done
  # trim down everything beyond 11th entry
  popd -n +11 2>/dev/null 1>/dev/null
  return 0
}