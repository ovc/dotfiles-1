#!/usr/bin/env bash
# Kill any existing (possibly stalled) instances of offlineimap and then run it again.

max_wait_count=3
wait_file="/tmp/offlineimap_wait.txt"

start_offlineimap() {
	offlineimap -u quiet &>> ~/.log/offlineimap &
	pid=$(pgrep '^offlineimap$')
	echo "Started offlineimap ($pid)."
}

increment_wait_file() {
	wait_count=$(read_wait_file)
	wait_count=$((${wait_count} + 1))
	echo "Incremented wait count to ${wait_count}." 1>&2
	echo "${wait_count}" > "$wait_file"
}

reset_wait_file() {
	echo "Reseted wait file."
	echo 0 > "$wait_file"
}

read_wait_file() {
	if [ -f "$wait_file" ]; then
		count=$(cat "$wait_file")
	else
		count="0"
	fi
	echo "Wait count = ${count}" 1>&2
	echo "$count"
}

if [ -z "${pid=$(pgrep '^offlineimap$')}" ]; then
		start_offlineimap
else
	wait_count=$(read_wait_file)
	if [ "$wait_count" -ge "$max_wait_count" ]; then
		echo "Killing offlineimap (${pid})"
		kill -9 "$pid"
		reset_wait_file
		start_offlineimap
	else
		increment_wait_file
	fi
fi

exit 0
