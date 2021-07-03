#!/usr/bin/env bash

if [ $1 -eq 1 ] 
then
	pactl set-sink-volume @DEFAULT_SINK@ +5% 
else
	pactl set-sink-volume @DEFAULT_SINK@ -5% 
fi

~/.local/bin/notify-static -i 1 -m " $(pamixer --get-volume)%"
