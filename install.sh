#! /bin/bash

PATH_DOTFILES=$HOME/.dotfiles
PATH_BACKUPS=$PATH_DOTFILES/backups
REPOSITORY_URL=decordoba/Linux-Config-Files.git

# Print warning message.
warn () {
  echo "$@" >&2
}

# Print warning message and exit.
die () {
  warn "$@"
  exit 1
}

# Ask question and read y/n answer.
ask () {
  echo -n "$@" '[y/n] ' ; read ans
  case "$ans" in
    y*|Y*) return 0 ;;
    *) return 1 ;;
  esac
}

# Get full_path for relative path.
# Does not go to source of symlinks (this is the difference to 'readlink -f').
full_path() {
  local full_path=$(readlink -f "$1")
  # Make sure that full_path points to symlink location, not to where it points
  if [ -L "$1" ] ; then
    # Convert to full_path manually
    [[ "$1" = /* ]] && full_path="$1" || full_path=$(pwd)/"$1"
    # Convert /tmp/a/../b/c.txt to /tmp/b/c.txt 
    full_path=$(readlink -f $(dirname "$full_path"))/$(basename "$1")
  fi
  echo $full_path
}

# Create symlink from $1 into $2.
# If $2 exists and it is not a symlink pointing at $1, backs it to $PATH_BACKUPS.
# All paths are converted to absolute paths.
create_ln_and_backup () {
  local origin="$1"
  local destination="$2"
  local full_origin=$(full_path "$origin")
  local full_destination=$(full_path "$destination")
  if [ ! -e "$full_origin" ] ; then
    warn "ERROR: '$full_origin' not found."
  elif [ ! -e "$full_destination" ] ; then
    ln -s "$full_origin" "$full_destination"
    echo Symlink created in \'"$full_destination"\'.
  elif [ ! -L "$full_destination" ] || [ $(full_path $(readlink -f "$full_destination")) != "$full_origin" ] ; then
    if [ ! -d "$PATH_BACKUPS" ] ; then
      mkdir -p "$PATH_BACKUPS"
      echo Backup folder created in \'"$PATH_BACKUPS"\'.
    fi
    if [ -L "$full_destination" ] ; then
      ln -s $(full_path $(readlink "$full_destination")) ""$PATH_BACKUPS"/$(basename "$full_destination")" && rm "$full_destination"
      echo Symlink in \'"$full_destination"\' moved to \'"$PATH_BACKUPS"\'.
    else
      mv "$full_destination" "$PATH_BACKUPS"
      if [ -d "$full_destination" ] ; then
        echo Folder in \'"$full_destination"\' moved to \'"$PATH_BACKUPS"\'.
      else
        echo File in \'"$full_destination"\' moved to \'"$PATH_BACKUPS"\'.
      fi
    fi
    ln -s "$full_origin" "$full_destination"
    echo Symlink created in \'"$full_destination"\'.
  fi
}

# Clones repository in $1 if it does not exist, or does git pull if it does.
# If there is any error in $1, writes warning and returns 1.
install_or_update_repo() {
  local folder
  if [ $# -lt 1 ] ; then
    folder="$PATH_DOTFILES"
  else
    folder="$1"
  fi
  if [ ! -e "$folder" ] || [ -z "$folder" ] ; then
    echo Installing dotfiles in \'"$folder"\'.
    git clone https://github.com/$REPOSITORY_URL "$folder"
  elif [ ! -d "$folder" ] ; then
    warn "ERROR: '$folder' already exists (and is not a folder). Remove it and try again."
    return 1
  else
    local current_path=$(pwd)
    cd "$folder"
    if [[ "$(git config --get remote.origin.url)" = *$REPOSITORY_URL ]] ; then
      echo Updating dotfiles in \'"$folder"\'.
      git pull origin master
    else
      warn "ERROR: '$folder' already exists (and does not contain the right repo). Remove it and try again."
      return 1
    fi
    cd "$current_path"
  fi
}

# Clone or update repo
install_or_update_repo "$PATH_DOTFILES" || exit 1

# Make sure not to overwrite backup folder
if [ -e "$PATH_BACKUPS" ] && [ ! -z "$PATH_BACKUPS" ] ; then
  now="$(date +%F_%T)"
  PATH_BACKUPS="$PATH_BACKUPS"_"${now//[:]/-}"
  unset now
fi

# Create and backup symlinks
create_ln_and_backup "$PATH_DOTFILES"/.bashrc $HOME/.bashrc
create_ln_and_backup "$PATH_DOTFILES"/.bash_profile $HOME/.bash_profile
create_ln_and_backup "$PATH_DOTFILES"/.bash.d $HOME/.bash.d
create_ln_and_backup "$PATH_DOTFILES"/.screenrc $HOME/.screenrc
create_ln_and_backup "$PATH_DOTFILES"/.inputrc $HOME/.inputrc
create_ln_and_backup "$PATH_DOTFILES"/.gitconfig $HOME/.gitconfig
mkdir -p $HOME/.vim
create_ln_and_backup "$PATH_DOTFILES"/.vim/vimrc $HOME/.vim/vimrc

# Source bashrc
source $HOME/.bashrc
echo File \'$HOME/.bashrc\' sourced.
