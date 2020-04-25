#!/usr/bin/sh

base=$(dirname `readlink -f "$0"`)

rm -rf ~/.vim
ln -sf "${base}/vim" ~/.vim
ln -sf "${base}/tmux.conf" ~/.tmux.conf
ln -sf "${base}/gdbinit" ~/.gdbinit
#git config --global user.useConfigOnly true
