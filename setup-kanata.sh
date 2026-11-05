#!/bin/bash
install_kanata() {
    # rustup was just installed in this run; make cargo available
    [ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

    echo "==> Checking for Kanata binary..."
    if ! command -v kanata &> /dev/null; then
        echo "==> Installing Kanata via cargo..."
        cargo install kanata
    else
        echo "==> Kanata binary already exists."
    fi

    echo "==> Setting up Kanata systemd service..."

    local repo_dir
    repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local service_src="$repo_dir/systemd/kanata.service"
    local service_dest="/etc/systemd/system/kanata.service"
    local config_file="$repo_dir/kanata/kanata.kbd"
    local kanata_bin
    kanata_bin="$(command -v kanata || echo "$HOME/.cargo/bin/kanata")"

    if [ ! -f "$service_src" ]; then
        echo "Error: Service file not found at $service_src"
        return 1
    fi
    if [ ! -f "$config_file" ]; then
        echo "Error: Config file not found at $config_file"
        return 1
    fi

    # Install a copy of the unit (system units under /home symlinks can be
    # unreliable at boot), filling in this machine's binary and config paths.
    sed -e "s|^ExecStart=.*|ExecStart=$kanata_bin --cfg $config_file|" \
        "$service_src" | sudo tee "$service_dest" > /dev/null

    sudo systemctl reset-failed kanata.service 2>/dev/null || true
    sudo systemctl daemon-reload
    sudo systemctl enable --now kanata.service
    sudo systemctl restart kanata.service

    sudo systemctl status kanata.service --no-pager
}

install_kanata
