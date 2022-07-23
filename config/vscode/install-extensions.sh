#!/bin/sh

set -u

# code --list-extensions > ~/.config/vscode/list-extensions.txt
while read name; do
    code --install-extension "$name" --force
done <~/.config/vscode/list-extensions.txt
