#!/bin/sh

cp -r ~/.zshrc .
cp -r ~/.vimrc .
cp -r ~/.tmux.conf .

mkdir -p .vim
cp -r ~/.vim/colors .vim

tree -a
git status --short
