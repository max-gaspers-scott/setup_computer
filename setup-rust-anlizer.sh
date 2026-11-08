#!/bin/sh
# Install rust-analyzer as a rustup component so it matches the active toolchain.
# (Don't also install the pacman package: rustup's ~/.cargo/bin/rust-analyzer
# proxy shadows /usr/bin/rust-analyzer, and the versions drift apart.)
# Safe to re-run: skips if already installed.

[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

if ! command -v rustup >/dev/null 2>&1; then
    echo "==> rustup not found; run setup-rustup.sh first. Skipping rust-analyzer."
elif rustup component list --installed | grep -q '^rust-analyzer'; then
    echo "==> rust-analyzer already installed, skipping."
else
    echo "==> Installing rust-analyzer component..."
    rustup component add rust-analyzer
fi
