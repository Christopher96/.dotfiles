wifi() {
    sudo pkill wpa_supplicant
    sudo wpa_supplicant -B -i wlan0 -c<(wpa_passphrase $1 $2)
    sudo ip route flush dev wlan0
    sudo ip addr flush dev wlan0 
    sudo dhcpcd wlan0
}

urlencode() {
    local i= char= url=$*
    declare -i len=${#url}

    for (( i = 0; i < len; i++ )); do
        char=${url:i:1}
        case "$char" in
            [a-zA-Z0-9.~_-]) printf "$char" ;;
            ' ') printf + ;;
            *) printf '%%%X' "'$char" ;;
        esac
    done
}

r() {
    SHELL=$HOME/.local/bin/r.shell

	local IFS=$'\t\n'
	local tempfile="$(mktemp -t tmp.XXXXXX)"
	local ranger_cmd=(
		command
		ranger

		--cmd="map S chain shell echo %d > "$tempfile"; quitall"
	)
	
	${ranger_cmd[@]} "$@"
	if [[ -f "$tempfile" ]] && [[ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]]; then
		cd -- "$(cat "$tempfile")" || return
	fi
	command rm -f -- "$tempfile" 2>/dev/null
}

bits() {
    for file in "$@"; do
        [[ -d "$file" ]] && continue
        printf "%1u\t%s\n" "$(( $(wc -c < "$file") * 8 ))" "$file"
    done
}

secret() {
    file="$HOME/.secrets"
    if [ -f "$file" ]; then
        cat $file | grep $1 | cut -d: -f2 | tr -d '[:space:]'
    else
        echo "no .secrets file"
    fi
}

alias pb="pb --apikey=$(secret pushbullet)"
