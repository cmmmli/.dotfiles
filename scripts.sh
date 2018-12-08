#!/bin/bash

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh


ln -sf ./zsh/my_zshrc.sh $HOME/zshrc
ln -sf ./vim/.vimrc $HOME/.vimrc
mkdir -p $HOME/vimbackup
ln -sf $HOME/.dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -s $HOME/.dotfiles/git/.gitconfig $HOME/.gitconfig
ln -s $HOME/.dotfiles/git/.gitignore_global $HOME/.gitignore_global

mkdir -p ~/iterm2
ln -s ./iterm2/com.googlecode.iterm2.plist ~/iterm2/com.googlecode.iterm2.plist

mkdir -p $HOME/.git_template/hooks
cp ./git/hooks/pre-push $HOME/.git_template/hooks/pre-push
