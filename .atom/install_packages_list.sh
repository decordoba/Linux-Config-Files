filename=$HOME/.atom/packages.list
if [ ! -e $filename ] ; then
    echo "Error: '$filename' does not exist"
    return 1
fi
backup=$HOME/.atom/packages.list.backup
[ -e $backup ] && backup=$HOME/.atom/packages.list.$(date +%Y%m%d-%H%M).backup
apm list --installed --bare > $backup
if [ -z "$(cmp --silent $filename $backup)" ] ; then
    rm $backup
    echo "Your current atom packages are the same as the ones in '$filename'."
    echo "There is not need to update or install any package."
else
    apm install --packages-file $filename
    echo "Installed all packages in '$filename'."
    echo "Backup of old packages created in '$backup'"
fi
