#!/usr/bin/sh

base=$(dirname `readlink -f "$0"`)

ln -sf "${base}/tmux.conf" ~/.tmux.conf
ln -sf "${base}/vimrc" ~/.vimrc
rm -rf ~/.vim
ln -sf "${base}/vim" ~/.vim
