#!/usr/bin/env bash

# adapted from the solutions found in
# https://www.reddit.com/r/unixporn/comments/3358vu/i3lock_unixpornworthy_lock_screen/

# icon="$HOME/.config/i3/images/lock.png"
# tmpfilepath="$HOME/.config/i3/images/.tmplock"
# tmpfilejpg=$tmpfilepath".jpg"
# tmpfilepng=$tmpfilepath".png"
#
# scrot -q1 -m "$tmpfilejpg"
# convert "$tmpfilejpg" -scale 10% -scale 1000% "$tmpfilepng"
#
# image_size=$(identify "$icon" | grep -o '[0-9]*x[0-9]*' | head -n 1)
# image_width=$(echo "$image_size" | cut -d'x' -f1)
# image_height=$(echo "$image_size" | cut -d'x' -f2)
#
# for res in $(xrandr -q | sed -e 's/ primary//' | grep ' connected' | cut -d' ' -f3); do
# 	screen_x=$(echo $res | cut -d'x' -f1)
# 	screen_y=$(echo $res | cut -d'x' -f2 | cut -d'+' -f1)
# 	off_x=$(echo $res | cut -d'x' -f2 | cut -d'+' -f2)
# 	off_y=$(echo $res | cut -d'x' -f2 | cut -d'+' -f3)
#
# 	x=$(($off_x + $screen_x/2 - $image_width/2))
# 	y=$(($off_y + $screen_y/2 - $image_height/2))
#
# 	convert "$tmpfilepng" "$icon" -geometry "+$x+$y" -composite -matte "$tmpfilepng"
# done
#
# i3lock -i "$tmpfilepng"
# rm "$tmpfilejpg"
# rm "$tmpfilepng"

icon="$HOME/.config/i3/images/lock.png"
tmpfilepath="$HOME/.config/i3/images/.tmplock"
tmpfilejpg=$tmpfilepath".jpg"
tmpfilepng=$tmpfilepath".png"

scrot -q1 -m "$tmpfilejpg"
convert $tmpfilejpg -scale 10% -scale 1000% $tmpfilejpg
convert $tmpfilejpg $icon -gravity center -composite -matte $tmpfilepng
i3lock -u -i $tmpfilepng
rm "$tmpfilejpg"
rm "$tmpfilepng"
