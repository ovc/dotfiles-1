#!/usr/bin/env sh
# Allow restart of DWM with out affecting other apps.
# Kill with $(pkill -f startdwm)

while true; do
    dwm 2> ~/.log/dwm.log
done
