#!/bin/sh
# Install uv. Safe to re-run: skips if already installed.

if command -v uv >/dev/null 2>&1 || [ -x "$HOME/.local/bin/uv" ]; then
    echo "==> uv already installed, skipping."
else
    echo "==> Installing uv..."
    # UV_NO_MODIFY_PATH: bash/.bashrc already adds ~/.local/bin to PATH,
    # and ~/.bashrc is a stow symlink into this repo.
    curl -LsSf https://astral.sh/uv/install.sh | env UV_NO_MODIFY_PATH=1 sh
fi
