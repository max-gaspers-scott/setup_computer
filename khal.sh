#!/bin/bash
# khal (terminal calendar) + vdirsyncer (CalDAV sync with Mail-in-a-Box).
# Configs live in the khal/ and vdirsyncer/ stow packages (setup-dotfiles.sh).
# Login: max@team-stingray.com, password from: pass show box.team-stingray.com

setup_khal() {
    yay -S --noconfirm --needed khal vdirsyncer

    if ! pass show box.team-stingray.com &> /dev/null; then
        echo "==> khal: pass entry 'box.team-stingray.com' missing; skipping sync."
        echo "    Create it with: pass insert box.team-stingray.com"
        echo "    Then re-run: . ./khal.sh"
        return 0
    fi

    mkdir -p "$HOME/.local/share/calendars"
    yes | vdirsyncer discover calendars
    vdirsyncer metasync
    vdirsyncer sync

    systemctl --user daemon-reload
    systemctl --user enable --now vdirsyncer.timer
}

setup_khal
