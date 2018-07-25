#!/bin/sh

ln -s ./zsh/my_zshrc.sh ~/.zshrc
ln -s ./vim/.vimrc ~/.vimrc
ln -sf ~/.dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json

mkdir -p ~/iterm2
ln -s ./iterm2/com.googlecode.iterm2.plist ~/iterm2/com.googlecode.iterm2.plist
