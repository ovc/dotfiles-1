#!/usr/bin/env bash
# Toggle xautolock. There is now way of querying the state so assume that it is enabled the first time this script is called and only this script enable/disables it.

state_file="/tmp/${USER}_xautolock_status.txt"

enable_screen_blanking() {
	xset +dpms
	sleep 1; xset s 900
}

disable_screen_blanking() {
	xset -dpms
}

# Read state.
if [ -f "$state_file" ]; then
	state=$(cat "$state_file")
else
	state="enabled"
fi

# Do action.
if [ "$state" = "enabled" ]; then
	xautolock -disable
	disable_screen_blanking
else
	xautolock -enable
	enable_screen_blanking
fi

# Change state.
if [ "$state" = "enabled" ]; then
	state="disabled"
else
	state="enabled"
fi

# Save state.
echo "$state" > "$state_file"

notify-send -a "${0##*/}" "xautolock is ${state}."
