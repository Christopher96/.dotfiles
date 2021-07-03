
# Input monitor and assign it to a variable
OPTS=`getopt -o m:y:s: -- "$@"`
eval set -- "$OPTS"

while true; do
  case "$1" in
    -m ) MONITOR="$2"; shift 2 ;;
    -- ) shift; break ;;
    * ) break ;;
  esac
done

# Get all windows from every active workspace with the target monitor
WINDOWS="$(i3-msg -t get_tree | jq 'recurse(.nodes[]) | select(.type == "workspace") | select (.fullscreen_mode == 1) | select(.output == "'$MONITOR'") | recurse(.nodes[]) | select(.window != null) | .window')"

FOCUSED="$(xdotool getwindowfocus)"

#Choose what format to use:
#-Show short output if there are more than one window on desktop
#-Show full output if there is only one window on desktop

if [[  $(wc -l <<< $WINDOWS) = 1 ]]; then
    FORMAT="-f3-"
else
    FORMAT="-f3"
fi

# Get colors from .Xresources to match polybar
FG=$(xrdb -query | awk '/polybar.foreground_alt:/ {print $2}')
BG=$(xrdb -query | awk '/polybar.background:/ {print $2}')

#Get WM_CLASS string from all IDs
for wid in $WINDOWS; do
	#Get window's class
	wclass="$(< "/proc/${1:-$(xdotool getwindowpid $wid)}/comm")"

	#Get window's name
	wname="$(xprop -id $wid WM_NAME | cut -d " " $FORMAT)"

	#Get rid of quotation marks
	wname="$(echo ${wname//\"})"

	#Uppercase first character of window class
	wname="$(tr '[:lower:]' '[:upper:]' <<< ${wname:0:1})${wname:1}"
	wclass="$(tr '[:lower:]' '[:upper:]' <<< ${wclass:0:1})${wclass:1}"

	#If window is focused - highlight it with green color
	#Use either $wmclass or $wmname to choose what to display
	if [[ "$wid" = "$FOCUSED" ]]; then
		win="$(printf "%s" "%{F"$FG"}%{F-} $wclass")"
	else
		win=" $wclass"
	fi

	windowlist="$windowlist $win"
done

#Result

echo "$windowlist"
