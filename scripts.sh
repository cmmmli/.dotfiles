#!/bin/bash

# homebrew install
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install git vim

curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
export ZPLUG_HOME=~/.zplug
git clone https://github.com/zplug/zplug $ZPLUG_HOME

git clone https://github.com/cmmmli/.dotfiles.git ~/.dotfiles
ln -sf $HOME/.dotfiles/zsh/my_zshrc.sh $HOME/.zshrc
ln -sf $HOME/.dotfiles/vim/.vimrc $HOME/.vimrc

mkdir -p $HOME/vimbackup
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/tomasr/molokai $HOME/.vim/colors/molokai
cp $HOME/.vim/colors/molokai/colors/molokai.vim $HOME/.vim/colors/molokai.vim
vim +PluginInstall +qall

ln -sf $HOME/.dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -s $HOME/.dotfiles/git/.gitconfig $HOME/.gitconfig
ln -s $HOME/.dotfiles/git/.gitignore_global $HOME/.gitignore_global
mkdir -p $HOME/.git_template/hooks
cp ./git/hooks/pre-push $HOME/.git_template/hooks/pre-push

mkdir -p ~/iterm2
ln -s $HOME/.dotfiles/iterm2/com.googlecode.iterm2.plist ~/iterm2/com.googlecode.iterm2.plist

# rbenv/ruby install
brew install rbenv
rbenv init
# ruby_version = rbenv install --list | grep '^[2-9].*\.[1-9]$' | tail -n1
# rbenv install $ruby_version
# rbenv global $ruby_version

brew install ghq peco ccat htop circleci gcc tree
