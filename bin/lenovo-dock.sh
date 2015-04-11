#!/usr/bin/env bash
# Ececuted on dock/undock ACPI events.
# TODO fix so caller has correct PATH for erikw set.
# TODO remove pulseaudio stuff when pa works again, https://bugzilla.redhat.com/show_bug.cgi?id=1034882


export DISPLAY=":0"
export PULSE_RUNTIME_PATH=/run/user/100/pulse/		# Needed so pacmd can find the PID of pulseaudio.

notify() {
	message="$1"
	local progname="${0##*/}"
	notify-send -a "$progname" "$message"
}

dock() {
	pacmd set-sink-port 0 analog-output
	$HOME/bin/dualscreen.sh dell24 enable
	$HOME/bin/xautolockctl disable
	$HOME/bin/xkbset
	notify "Laptop docked."
}

undock() {
	pacmd set-sink-port 0 analog-output-speaker
	$HOME/bin/dualscreen.sh dell24 disable
	$HOME/bin/xautolockctl enable
	notify "Laptop undocked."
}

if [ "$#" -ne 1 ]; then
	echo "One argument expected: dock|undock" 1>&2
	exit 1
elif [ "$1" == "dock" ]; then
	dock
	exit 0
elif [ "$1" == "undock" ]; then
	undock
	exit 0
else
	echo "Argument \"$1\" not recognized."
	exit 2
fi
