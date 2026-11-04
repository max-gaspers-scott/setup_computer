#!/bin/sh

sudo pacman -S --no-conferm --needed base-devel
git clone https://aur.archlinux.org/paru.git || echo "faild to clone paru, may already exist"
cd paru && makepkg -si
