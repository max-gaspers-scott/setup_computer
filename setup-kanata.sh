#!/bin/sh
install_kanata() {
    echo "==> Checking for Kanata binary..."
    if ! command -v kanata &> /dev/null; then
        echo "==> Installing Kanata via cargo..."
        cargo install kanata
    else
        echo "==> Kanata binary already exists."
    fi

    echo "==> Setting up Kanata systemd service..."

    # Use absolute path based on the current working directory or home path
    local repo_dir="/home/mgs/setup_computer"
    local service_src="$repo_dir/systemd/kanata.service"
    local service_dest="/etc/systemd/system/kanata.service"
    local config_file="$repo_dir/kanata/kanata.kbd"

    # Verify files exist in the repo before linking
    if [ ! -f "$service_src" ]; then
        echo "Error: Service file not found at $service_src"
        return 1
    fi

    if [ ! -f "$config_file" ]; then
        echo "Error: Config file not found at $config_file"
        return 1
  fi 

    # Reset any previous failed state so systemd doesn't block startup
    sudo systemctl reset-failed kanata.service 2>/dev/null || true

    # Symlink the service file
    sudo ln -sf "$service_src" "$service_dest"

    # Reload systemd, enable, and start the service
    sudo systemctl daemon-reload
    sudo systemctl enable --now kanata.service

    echo "==> Kanata service installed and started successfully."
    
    # Verification
    sudo systemctl status kanata.service --no-pager
}

# Run the installation
install_kanata
