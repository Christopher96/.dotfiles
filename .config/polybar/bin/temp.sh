#!/bin/sh
sensors | grep Tctl | head -1 | cut -d: -f2 | sed 's/ //g'
