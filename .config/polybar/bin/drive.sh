#!/bin/sh

drive quota | (

while read line; do
    if [ "$line" != "${line/Used/}" ]; then
        used=${line#*(}
        used=${used%G*}
    elif [ "$line" != "${line/Total/}" ]; then
        total=${line#*(}
        total=${total%G*}
    fi
done

echo "$used/$total GB"
)


