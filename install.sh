#!/bin/bash
TERM_SETUP_REPO="https://github.com/shshekhar93/terminal-setup.git"
TERM_SETUP_DIR=".scripts"
BASH_PROFILE=".bash_profile"
BASHRC=".bashrc"

function download_repo() {
    if [ -e $TERM_SETUP_DIR ]; then
        rm -rf $TERM_SETUP_DIR
    fi

    git clone $TERM_SETUP_REPO
    mv terminal-setup $TERM_SETUP_DIR
}

function setup_sourcing() {
    if [ -e $BASH_PROFILE ]; then
        USER_PROFILE="$BASH_PROFILE"
    else
        USER_PROFILE="$BASHRC"
    fi

    echo "Setting up terminal scripts in $USER_PROFILE"

    printf "%s\n" "# Terminal setup" "if [ -e \"\$HOME/$TERM_SETUP_DIR\" ]; then" "  source \$HOME/$TERM_SETUP_DIR/aliases.sh" "  source \$HOME/$TERM_SETUP_DIR/custom-vars.sh" "fi" >> $USER_PROFILE
}

SAVED_CWD=$(pwd)
cd $HOME
download_repo
setup_sourcing
cd $SAVED_CWD
