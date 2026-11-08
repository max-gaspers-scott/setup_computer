#!/bin/sh
# Install rustup + the stable toolchain. Safe to re-run: skips if already installed.

# Pick up an existing rustup install that isn't on PATH yet
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

if command -v rustup >/dev/null 2>&1; then
    echo "==> rustup already installed, skipping."
else
    echo "==> Installing rustup..."
    # -y: non-interactive. --no-modify-path: bash/.bashrc already sources
    # ~/.cargo/env, and ~/.bashrc is a stow symlink into this repo.
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
    . "$HOME/.cargo/env"
fi

# Make sure a default toolchain exists (rustup can be installed without one)
if ! rustup default >/dev/null 2>&1; then
    echo "==> Setting default toolchain to stable..."
    rustup default stable
fi
