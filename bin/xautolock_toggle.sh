#!/usr/bin/env bash
# Toggle xautolock. There is now way of querying the state so assume that it is enabled the first time this script is called and only this script enable/disables it.
# TODO post a toggle disalbe job like Caffeine
# TODO on disable remove any queried at jobs

state_file="/tmp/${USER}_xautolock_status.txt"

save_state() {
	local state="$1"
	echo "$state" > "$state_file"
}
enable_screen_blanking() {
	xset +dpms
	sleep 1; xset s 900
}

disable_screen_blanking() {
	xset -dpms
}

enable_screensaver() {
	xautolock -enable
}

disable_screensaver() {
	xautolock -disable
}

read_state() {
	if [ -f "$state_file" ]; then
		cat "$state_file"
	else
		echo "enabled"
	fi
}

notify_state() {
	local state="$1"
	notify-send -a "${0##*/}" "xautolock is ${state}."
}

state=$(read_state)
if [ "$state" = "enabled" ]; then
	disable_screensaver
	disable_screen_blanking
else
	enable_screensaver
	enable_screen_blanking
fi

# Change state.
if [ "$state" = "enabled" ]; then
	state="disabled"
else
	state="enabled"
fi

save_state "$state"
notify_state "$state"
