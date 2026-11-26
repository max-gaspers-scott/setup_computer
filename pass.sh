#!/bin/bash
# pass (password store) + the Mail-in-a-Box password used by himalaya and vdirsyncer.
# Idempotent: each step is skipped if already done. Prompts interactively for
# the GPG passphrase and the mailbox password the first time.

setup_pass() {
    local mail_entry="box.team-stingray.com"
    local gpg_uid="maximillian gaspers scott <max@team-stingray.com>"

    yay -S --noconfirm --needed pass gnupg

    # 1. GPG key to encrypt the store
    if ! gpg --list-secret-keys --with-colons 2>/dev/null | grep -q '^sec'; then
        echo "==> pass: no GPG key found, creating one for $gpg_uid"
        echo "    (you'll be asked to choose a passphrase)"
        gpg --quick-generate-key "$gpg_uid" default default never || return 1
    fi

    # 2. Initialize the store with the first secret key
    if [ ! -f "${PASSWORD_STORE_DIR:-$HOME/.password-store}/.gpg-id" ]; then
        local fpr
        fpr="$(gpg --list-secret-keys --with-colons | awk -F: '/^fpr/ {print $10; exit}')"
        echo "==> pass: initializing store with key $fpr"
        pass init "$fpr" || return 1
    fi

    # 3. Mail-in-a-Box password (mail + calendar share the same login)
    if ! pass show "$mail_entry" &> /dev/null; then
        echo "==> pass: enter the password for max@team-stingray.com"
        pass insert "$mail_entry" || return 1
    fi
}

setup_pass
