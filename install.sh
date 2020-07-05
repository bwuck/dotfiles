#!/bin/sh

PWD=`pwd`

# Author and maintainer.
REPORT_BUG_EMAIL="bwuck@bwuck.com"
AUTHOR_EMAIL="bwuck@bwuck.com"

# Enable this line to switch on logging and debugging.
#_DEBUG="true"

if [[ "$_DEBUG" == "true" ]]; then
    function _log() {
        echo 1>&2 "$@"
    }
else
    function _log() {
        # Do nothing.
        echo -n
    }
fi


# Detect essential system configuration.
HOSTNAME=`hostname`
WHOAMI=`whoami`

FISH_CONFIG_DIR="~/.config/fish"

# Determine the directory this source file is in.
# From: http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ];
do
    SOURCE="$(readlink "$SOURCE")";
done
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd -P "$( dirname "$SOURCE" )" && pwd )"
INSTALL_DIR=$DOTFILES_DIR/install/

# OS-independent installation.

# Install spacemacs configuration for emacs.
git clone \
    --single-branch \
    --branch develop \
    https://github.com/syl20bnr/spacemacs ~/.emacs.d
ln -s $DOTFILES_DIR/spacemacs.d ~/.spacemacs.d

# Fish shell configuration.
#mkdir -p $FISH_CONFIG_DIR
ln -s $DOTFILES_DIR/config/fish $FISH_CONFIG_DIR
#ln -s "$DOTFILES_DIR/config/fish/functions" "$FISH_CONFIG_DIR/functions"
#ln -s "$DOTFILES_DIR/config/fish/config.fish" "$FISH_CONFIG_DIR/config.fish"

# OS-dependent installation.
# To disable a script, simply change its extension
# to anything other than `.sh`. To reorder a script,
# change its number prefix.
if [ -e $SHELLRC_DIR/install/$OSTYPE ]; then
    for f in $SHELLRC_DIR/install/$OSTYPE/*.sh
    do
        _log "Loading $f"
        source $f
    done
    unset f
else
    echo "ERROR: Unknown \$OSTYPE: $OSTYPE."
    echo "Please report this \$OSTYPE to $REPORT_BUG_EMAIL."
fi
