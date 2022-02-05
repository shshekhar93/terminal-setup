#!/bin/bash
TERM_SETUP_REPO="https://github.com/shshekhar93/terminal-setup.git"
TERM_SETUP_DIR=".scripts"
BASH_PROFILE=".bash_profile"
BASHRC=".bashrc"
GIT_PATH=$(which git0)

function install_git() {
    sudo apt install git
}

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

if [ "$UID" == "0" ]; then
    echo "This script should not be run as root."
    echo "If you used sudo, don't."
    exit 1
fi

if [ "$GIT_PATH" == "" ]; then 
    install_git
fi

SAVED_CWD=$(pwd)
cd $HOME
download_repo
setup_sourcing
cd $SAVED_CWD
