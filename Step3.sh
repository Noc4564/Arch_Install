#!/bin/bash

source config.txt

# clone repo
git clone --bare git@github.com:"$git" /home/"$userName"/.dotfiles
git --git-dir=/home/"$userName"/.dotfiles/ --work-tree=/home/"$userName" checkout
git --git-dir=/home/"$userName"/.dotfiles/ --work-tree=/home/"$userName" config --local status.showUntrackedFiles no

