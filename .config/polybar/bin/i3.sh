#!/bin/bash
source $HOME/.cache/wal/colors.sh

FG=$(xgetres polybar.foreground)
FG_ALT=$(xgetres polybar.foreground_alt)
BG=$(xgetres polybar.background)
BG_ALT=$(xgetres polybar.background_alt)

workspaces=`i3-msg -t get_workspaces`
echo $workspaces | jq '. | .[] | .focused'

function printIcons() {
    echo $1 | awk '{print $2}' | tr -d \" | while read name; do
        if [$2]; then 
            echo "%{O-18}%{F$FG_ALT}%{T3}%{T-}%{F-}%{F$FG}%{B$FG_ALT}$name%{B-}%{F-}%{F$FG_ALT}%{T3}%{T-}%{F-}";
        else 
            echo "asdf";
        fi
    done
}
