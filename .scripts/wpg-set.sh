wpg -s "$1" && ./polybar.sh
echo "/mnt/share/backgrounds/live/$2" > $HOME/.scripts/wallpaper-save
./wallpaper-wrap
