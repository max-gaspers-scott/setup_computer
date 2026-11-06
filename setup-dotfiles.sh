#!/bin/bash
# Symlink dotfiles into $HOME with GNU stow.
# Each package dir mirrors the layout under $HOME, e.g.
#   bash/.bashrc             -> ~/.bashrc
#   nvim/.config/nvim/...    -> ~/.config/nvim/...
# Add a new package: create the dir and add its name to PACKAGES.

setup_dotfiles() {
    local repo_dir
    repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local packages=(bash hypr nvim himalaya)
    local backup_suffix=".bak.$(date +%Y%m%d%H%M%S)"

    if ! command -v stow &> /dev/null; then
        echo "Error: stow is not installed (run setup-stow.sh)"
        return 1
    fi

    for pkg in "${packages[@]}"; do
        echo "==> Stowing $pkg"

        # Back up any real (non-symlink) files that would block stow.
        while IFS= read -r -d '' src; do
            local rel="${src#"$repo_dir/$pkg/"}"
            local dest="$HOME/$rel"
            # Skip if dest already resolves to the repo file (e.g. a parent dir is a stow symlink).
            if [ "$(realpath "$dest" 2>/dev/null)" = "$(realpath "$src")" ]; then
                continue
            fi
            if [ -e "$dest" ] && [ ! -L "$dest" ]; then
                echo "    backing up $dest -> $dest$backup_suffix"
                mv "$dest" "$dest$backup_suffix"
            fi
        done < <(find "$repo_dir/$pkg" \( -type f -o -type l \) -print0)

        stow --dir="$repo_dir" --target="$HOME" --restow "$pkg"
    done
}

setup_dotfiles
