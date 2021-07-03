#!/bin/bash
ipsave="$HOME/.config/polybar/bin/ip"

if [ "$1" == "--public" ]
  then
    ip=$(curl -s checkip.dyndns.org | sed 's#.*Address: \(.*\)</b.*#\1#')
    echo $ip > $ipsave
fi

if [ "$1" == "--local" ]
  then
    ip=$(ip a | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')
    echo $ip > $ipsave
fi

cat $ipsave
