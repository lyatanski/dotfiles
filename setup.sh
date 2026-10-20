#!/usr/bin/sh

base=$(dirname `readlink -f "$0"`)

rm -rf ~/.vim
ln -sf "${base}/vim" ~/.vim
mkdir -p ~/.config/nvim
ln -sf "${base}/nvim/init.vim" ~/.config/nvim/init.vim
ln -sf "${base}/tmux.conf" ~/.tmux.conf
ln -sf "${base}/palette.conf" ~/.palette.conf
ln -sf "${base}/gdbinit" ~/.gdbinit
#git config --global user.useConfigOnly true
