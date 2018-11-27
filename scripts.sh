#!/bin/bash

ln -s ./zsh/my_zshrc.sh ~/.zshrc
ln -s ./vim/.vimrc ~/.vimrc
ln -sf ~/.dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -s ~/.dotfiles/git/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/git/.gitignore_global ~/.gitignore_global

mkdir -p ~/iterm2
ln -s ./iterm2/com.googlecode.iterm2.plist ~/iterm2/com.googlecode.iterm2.plist

mkdir -p ~/.git_template/hooks
cp ./git/hooks/pre-push ~/.git_template/hooks/pre-push
