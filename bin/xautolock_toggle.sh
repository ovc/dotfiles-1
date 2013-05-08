#!/usr/bin/env bash
# Toggle xautolock. There is now way of querying the state so assume that it is enabled the first time this script is called and only this script enable/disables it.

state_file="/tmp/${USER}_xautolock_status.txt"

# Read state.
if [ -f "$state_file" ]; then
	state=$(cat "$state_file")
else
	state="enabled"
fi

# Do action.
if [ "$state" = "enabled" ]; then
	xautolock -disable
else
	xautolock -enable
fi

# Change state.
if [ "$state" = "enabled" ]; then
	state="disabled"
else
	state="enabled"
fi
echo "$state" > "$state_file"

notify-send -a "${0##*/}" "xautolock is ${state}."
