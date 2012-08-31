#!/usr/bin/env bash
# Watch Maildir inboxes for new mails and send a summary notification with notify-send. Tested and "works perfectly" with dunst.
# Dependencies: inotifywait from inotify-tools package.

maildir_path="$HOME/.mail"		# Path to Maildir root.
mailboxes=(inbox lists)			# Mailboxes to watch.
watchdirs=$(for box in ${mailboxes[*]}; do echo ${maildir_path}/$box/new; done)

# Let inotifywait monitor changes and output each event on it's own line.
while read line; do
	# Split inotify output to get path and the file that was added.
	parts=($(echo "$line" | sed -e 's/ \(CREATE\|MOVED_TO\) / /'))
	inbox_path="${parts[0]}"
	inbox=$(echo "$inbox_path" | grep -Po "(?<=/)\w+(?=/new)")
	mail="${parts[1]}"

	# Get subject and trim length.
	subject=$(grep "Subject:" ${inbox_path}/${mail} | cut -c1-20)
	# Get from field.
	from=$(grep "From:" ${inbox_path}/${mail})
	# Get the body. First scroll down to body then strip signature, empty lines, join lines, substitute spaces to get more text and limit length.
	body=$(sed '1,/^$/d'  "${inbox_path}/${mail}" | sed -n '/-- /q;p' | sed '/^ *$/d' | tr "\\n" ' ' | sed 's/\s\s*/ /g' | cut -c1-80)
	# Notify summary string.
	out_summary=$(printf "[%s] %s, %s\\n" "$inbox" "$from" "$subject")
	# Notify body string.
	out_body=$(printf ", Body: %s [...]\n" "$body")
	# Send the message with the name this scrip was invoked with.
	notify-send -a "${0##*/}" "$out_summary" "$out_body"
done < <(inotifywait --monitor --event create --event moved_to ${watchdirs} 2>/dev/null)
