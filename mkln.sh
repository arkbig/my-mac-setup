#!/usr/bin/env bash
set -eux

mkln () {
    if [ -e "$2" ]; then
        rm "$2"
    elif [ ! -d "$(dirname "$2")" ]; then
        mkdir -p "$(dirname "$2")"
    fi
    ln -s "$1" "$2"
}

BASEDIR=$(cd "$(dirname "$0")" && pwd)
mkln "$BASEDIR/config" ~/.config

mkln ~/.config/zsh/.zshrc ~/.zshrc
mkln ~/.config/zsh/.zprofile ~/.zprofile

mkln ~/.config/git/.gitconfig ~/.gitconfig

mkln ~/.config/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
