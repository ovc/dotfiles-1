#!/bin/bash
# Kill any existing (possibly stalled) instances of offlineimap and then run it again.
max_wait_times=4
pid=$(pgrep '^offlineimap$')
wait_file=/tmp/offlineimap_wait.txt
run_now=1
if ([[ -n "$pid" ]] && echo $pid); then
	if [ -f $wait_file ]; then
		CUR_WAIT=`cat $wait_file`
	else
		CUR_WAIT=0
	fi

	if [ "$CUR_WAIT" == "$max_wait_times" ]; then
		rm $wait_file
		pkill '^offlineimap$' > /dev/null;
		echo "rm'd $wait_file and pkilled offlineimap."
	else
		echo "$CUR_WAIT + 1" | bc > $wait_file
		run_now=0
		echo -n "Incremeted $wait_file, new value: "
		cat $wait_file
	fi
else
	rm -f $wait_file
	echo "rm'd $wait_file (if it existed)."
fi

if (($run_now)); then
	offlineimap -o -u quiet &>> ~/.log/offlineimap &
	pid=$(pgrep '^offlineimap$')
	echo "Started offlineimap ($pid)."
fi
exit 0
