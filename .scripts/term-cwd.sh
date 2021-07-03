#!/bin/bash

pid=$(xdotool getactivewindow getwindowpid)
title=$(xdotool getactivewindow getwindowname)

pname=$(ps -p $pid -o comm=)
if [[ "$pname" != "st" ]]; then
    exit
fi

function childpid {
    echo $(pgrep -P $1 | tail -1)
}

while true; do
    npid=$(childpid $pid)
    if [[ "$npid" == "" ]]; then
        break
    else
        pid=$npid
    fi
done

cname=$(ps -p $pid -o comm=)

case $cname in
    "vim") path=$(echo $title | egrep -o "\((.*?)\)" | sed 's/(//' | sed 's/)//') ;;
    "ranger") notify-send ranger ;;
    "zsh") path=$title ;;
esac

path=$(echo $path | sed 's/ /\\ /')
# notify-send "$path"
resolve_dir() {
    (builtin cd `dirname "${1/#~/$HOME}"`'/'`basename "${1/#~/$HOME}"` 2>/dev/null; if [ $? -eq 0 ]; then pwd; fi)
}
dir=`resolve_dir $path`
# notify-send "$dir"
sh -c 'cd '$dir' ; st'
