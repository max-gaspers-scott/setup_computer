#!/bin/bash
# Install cargo-binstall. Safe to re-run: skips if already installed.

[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

if command -v cargo-binstall >/dev/null 2>&1; then
    echo "==> cargo-binstall already installed, skipping."
else
    echo "==> Installing cargo-binstall..."
    sudo pacman -S --needed --noconfirm cargo-binstall
fi
