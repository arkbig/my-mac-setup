#! /bin/sh
set -u

(cd ~/.config/homebrew && (rm Brewfile ; brew bundle dump))

# https://derflounder.wordpress.com/2019/12/19/deploying-terminal-profile-settings-using-macos-configuration-profiles/
/usr/bin/plutil -extract Window\ Settings.Big xml1 -o - ~/Library/Preferences/com.apple.Terminal.plist > ~/.config/terminal/Big.terminal

code --list-extensions > ~/.config/vscode/list-extensions.txt
