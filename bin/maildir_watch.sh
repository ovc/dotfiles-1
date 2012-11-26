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
	subject=$(grep -i "Subject:" ${inbox_path}/${mail} | cut -c1-30)

	# Get from field and display name or email.
	from_row=$(grep -i "^From:" ${inbox_path}/${mail} | sed 's/From:\s*//I')
	from_name=$(echo "$from_row" | grep -Po "[^<>]+(?=(?:<|$))")
	from_email=$(echo "$from_row" | grep -Po "(?<=<).+(?=>)")
	from="From: "
	if [ -n "$from_name" ]; then
		from="${from}${from_name}"
	elif [ -n "$from_email" ]; then
		from="${from}${from_email}"
	else
		from="${from}<unknown>"
	fi
	from=$(echo ${from} | cut -c1-30)

	# Get the body. First scroll down to body then strip signature, Content lines, random ID line, empty lines, join lines, substitute spaces to get more text and limit length.
	# TODO simplyfy by passing to HTML stripper or something.
	body=$(sed '1,/^$/d' "${inbox_path}/${mail}" | grep -v "^Content-.*:" | grep -v "^--[[:xdigit:]]\+" | sed -n '/-- /q;p' | sed '/^ *$/d' | tr "\\n" ' ' | sed 's/\s\s*/ /g' | cut -c1-80)
	# Notify summary string.
	out_summary=$(printf "[%s] %s, %s\\n" "$inbox" "$from" "$subject")
	# Notify body string.
	out_body=$(printf ", Body: %s [...]\\n" "$body")
	# Send the message with the name this scrip was invoked with.
	notify-send --app-name "${0##*/}" "$out_summary" "$out_body"
done < <(inotifywait --monitor --event create --event moved_to ${watchdirs} 2>/dev/null)
