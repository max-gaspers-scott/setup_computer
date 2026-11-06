#!/bin/bash
cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1

. ./setup-croc.sh
. ./setup-gdisk.sh
. ./setup-jrnl.sh
. ./setup-lsof.sh
# . ./setup-qwen.sh
. ./setup-rustup.sh # needs work
. ./setup-tmux.sh
. ./setup-tt.sh
# . ./setup-web-term.sh
# . ./setup-paru.sh
. ./setup-node.sh
. ./setup-pomodoro.sh
. ./spell.sh
. ./sqlx.sh
. ./asciiquarium.sh
. ./nyancat.sh
# . ./setup-goose.sh # uncomment to install goose
. ./setup-uv.sh
. ./cargo-binstall.sh
# . ./java.sh
# . ./setup-rust-anlizer.sh
. ./dig.sh
. ./setup-linode.sh

# Dotfiles: install stow, then symlink packages into ~
. ./setup-stow.sh
. ./setup-dotfiles.sh

# Kanata (needs cargo from setup-rustup.sh): install + enable/start systemd service
. ./setup-kanata.sh
. ./setup-csv.sh
. ./email.sh
. ./viu.sh
