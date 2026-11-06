#!/bin/bash
# Toggle the focused monitor between normal and rotated 90° left.
# Bound to CTRL + SHIFT + R in bindings.lua.
# Hyprland transforms: 0 = normal, 1 = 90°, 3 = 270° (swap 1 for 3 if it turns the wrong way).

ROTATED=1

mon=$(hyprctl monitors -j | jq -c '.[] | select(.focused)')
name=$(jq -r '.name' <<<"$mon")
current=$(jq -r '.transform' <<<"$mon")
mode=$(jq -r '"\(.width)x\(.height)@\(.refreshRate)"' <<<"$mon")
pos=$(jq -r '"\(.x)x\(.y)"' <<<"$mon")
scale=$(jq -r '.scale' <<<"$mon")

if [ "$current" = "0" ]; then new=$ROTATED; else new=0; fi

hyprctl eval "hl.monitor({ output = \"$name\", mode = \"$mode\", position = \"$pos\", scale = $scale, transform = $new })"
