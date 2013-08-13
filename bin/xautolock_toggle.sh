#!/usr/bin/env bash
# $ xautlockctl.sh 					# Toggle the state.
# $ xautlockctl.sh enable			# Enable xautlock.
# $ xautlockctl.sh disable			# Enable xautlock.
# $ xautlockctl.sh caffeine			# Disable for a default time out.
# $ xautlockctl.sh caffeine	[0-9]	# Disable the given amount of minutes from the current time.
#
# Control a running xautolock instance by enabling or disabling it. There is also a "caffeine" mode that can disable xautolock for a given time e.g. if you want to watch a movie for 2 hours without screen interruptions (inspired by the mac app with the same name). 
# NOTE There is now way of querying the state so assume that it is enabled the first time this script is called and only this script enable/disables it.

state_file="/tmp/xautolock_${USER}_status.txt"
atjobno_file="/tmp/xautolock_${USER}_atjobno.txt"
script_name="${0##*/}"
script_fpath="$(dirname $(readlink -f $0))/${script_name}"
default_disalbe_time="120"
arg_command="$1"

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

do_disable() {
	disable_screensaver
	disable_screen_blanking
	stop_atjob
}

do_enable() {
	enable_screensaver
	enable_screen_blanking
	stop_atjob
}

read_state() {
	if [ -f "$state_file" ]; then
		cat "$state_file"
	else
		echo "enabled"
	fi
}

save_atjobno() {
	local job_no="$1"
	echo "$job_no" > "$atjobno_file"
}

read_atjobno() {
	if [ -f "$atjobno_file" ]; then
		cat "$atjobno_file"
	fi
}

stop_atjob() {
	local job_no="$(read_atjobno)"
	if [ -n "$job_no" ]; then
		atrm "$job_no"
		rm "$atjobno_file"
	fi
}

toggle_state() {
	local state="$1"
	if [ "$state" = "enabled" ]; then
		echo "disabled"
	else
		echo "enabled"
	fi
}

parse_minutes_arg() {
	local minutes="$1"
	if [ -z "$minutes" ]; then
		echo "Using default time of ${default_disalbe_time} minutes." 1>&2
		minutes="${default_disalbe_time}"
	elif [[ ! "$minutes" =~ ^[0-9]+$ ]]; then
		echo "Second argument must be numeric." 1>&2
		return 1 # NOTE exit(1) from here does not work for some reasons.
	fi
	echo "$minutes"
}

notify() {
	local text="$1"
	notify-send -a "${script_name}" "$text"
}


state=$(read_state)

if [ "${arg_command}" == "caffeine" ]; then
	minutes="$(parse_minutes_arg "$2")"
	[ "$?" -ge 1 ] && exit 2
	job_no="$(echo "${script_fpath} enable" | at now + "$minutes" minute 2>&1 1>/dev/null | tail -1 | cut -d ' ' -f 2)"
	do_disable
	notify "Disabling screensaver for "$minutes" minutes. atjob=${job_no}."
	save_atjobno "$job_no"
	state="disabled"
elif [ "${arg_command}" == "enable" ]; then
	do_enable
	state="enabled"
elif [ "${arg_command}" == "disable" ]; then
	do_disable
	state="disabled"
else
	if [ "$state" == "enabled" ]; then
		do_disable
	elif  [ "$state" == "disabled" ]; then
		do_enable
	fi
	state=$(toggle_state "$state")
fi

save_state "$state"
notify "xautolock is ${state}."
