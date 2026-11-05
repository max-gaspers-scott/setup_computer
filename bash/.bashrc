# Omarchy environment (OMARCHY_PATH + PATH), needed even for non-interactive shells
[[ -r /usr/share/omarchy/default/bash/env-bootstrap ]] && source /usr/share/omarchy/default/bash/env-bootstrap

# If not running interactively, don't do anything else (leave this above the rc source)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source "$OMARCHY_PATH/default/bash/rc"

# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
# alias p='python'


# Add your own exports, aliases, and functions here.

alias gtree='git log --oneline --graph --decorate --all'

alias cb='git switch $(git branch | fzf)'

alias w='nvim $(find -maxdepth 1 -name "*.txt" -o -name "*.md" | fzf)'

alias cc='clear && cargo clippy'

alias needspace='docker system prune -a && cargo deepclean'

alias rust-book='rustup doc --book'


source ~/setup_computer/.linode-env/bin/activate


function fsr() {
  local trm="$1"
  ls | rg $trm | awk '{print $NF}'
}



# set vi mode always
set -o vi
bind 'set show-mode-in-prompt on'
bind 'set vi-ins-mode-string \1\e[32m\2(ins)\1\e[0m\2 '
bind 'set vi-cmd-mode-string \1\e[33m\2(cmd)\1\e[0m\2 '
# setup tmux dashbord/workspace
function dash() {

    if tmux has-session -t "Work" 2>/dev/null; then
        tmux attach-session -t "Work"
    else
        # 1. Create session and first window (Monitoring)
        tmux new-session -d -s "Work"
        tmux send-keys -t "Work" 'btop' Enter

        tmux split-window -v -p 30
        tmux send-keys -t "Work" 'intense-pomodoro' Enter

        tmux split-window -h

        tmux send-keys -t "Work" 'tty-clock -c -t -s' Enter
        # tmux select-window -t "Work:1"
        # tmux attach-session -t "Work"
        #
        # tmux split-window -h -p 30
        #

    # tmux send-keys -t "Work" 'cbonsai -li'
        #
        # 2. Create second window (Coding/Development)
        tmux new-window -t "Work" -n "TODO"
        tmux send-keys -t "Work" 'nvim notes/work.md' Enter
        
        # 3. Create third window (Logs or Misc)
        tmux new-window -t "Work" -n "Leniar"
        tmux send-keys -t "Work" 'linear-cli issues list --state TODO' Enter


        tmux new-window -t "Work" -n "chat"
        tmux send-keys -t "Work" 'bens-chat-cli' Enter

        tmux new-window -t "Work" -n "email"
        tmux send-keys -t "Work" 'himalaya envelope list' Enter


        # Select the 'Dev' window by default on startup
        tmux select-window -t "Work:2"
        tmux attach-session -t "Work"
    fi
}

function spell() {
  codespell --skip="node_modules, target, build, Cargo.lock, package-lock.json"
}
# Make an alias for invoking commands you use constantly
# alias p='python'
# 

# Added by Antigravity CLI installer
export PATH="/home/mgs/.local/bin:$PATH"

# kilo
export PATH=/home/mgs/.kilo/bin:$PATH
. "$HOME/.cargo/env"
export PATH="$HOME/.cargo/bin:$PATH"

. "$HOME/.local/share/../bin/env"
