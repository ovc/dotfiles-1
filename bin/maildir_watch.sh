#!/usr/bin/env bash
# Watch Maildir inboxes for new mails and send a summary notification with notify-send. Tested and "works perfectly" with dunst.
# Dependencies: inotifywait from inotify-tools package.

maildir_path="$HOME/.mail"		# Path to Maildir root.
mailboxes=(inbox lists)			# Mailboxes to watch.
watchdirs=$(for box in ${mailboxes[*]}; do echo ${maildir_path}/$box/new; done)

trim() {
    local var="$1"
    var="${var#"${var%%[![:space:]]*}"}"   # Remove leading whitespace characters.
    var="${var%"${var##*[![:space:]]}"}"   # Remove trailing whitespace characters.
    echo -n "$var"
}

parse_send() {
	local inbox="$1"
	local mailfile="$2"

	# Get subject and trim length.
	local subject=$(grep -i "Subject: " "$mailfile")
	subject=${subject:0:40}
	subject=$(trim "$subject")

	# Get from field and display name or email.
	local from_row=$(grep -i "^From:" "$mailfile" | sed 's/From:\s*//I')
	local from_name=$(echo "$from_row" | grep -Po "[^<>]+(?=(?:<|$))")
	local from_email=$(echo "$from_row" | grep -Po "(?<=<).+(?=>)")
	local from="From: "
	if [ -n "$from_name" ]; then
		from="${from}${from_name}"
	elif [ -n "$from_email" ]; then
		from="${from}${from_email}"
	else
		from="${from}<unknown>"
	fi
	from=${from:0:30}
	from=$(trim "$from")

	# Get the body. First scroll down to body, Content lines, random ID line, strip signature, convert HTML, remove empty lines, join lines, substitute spaces to get more text.
	local body=$(sed '1,/^$/d' "$mailfile" | grep -v "^Content-.*:" | grep -v "^--[[:xdigit:]]\+" | sed -n '/-- /q;p' | html2text | sed '/^ *$/d' | tr "\\n" ' ' | sed 's/\s\s*/ /g')
	body=${body:0:100}
	body=$(trim "$body")

	# Notify summary string.
	local out_summary=$(printf "[%s] %s, %s,\\n" "$inbox" "$from" "$subject")
	# Notify body string.
	local out_body=$(printf "Body: %s [...]\\n" "$body")
	# Send the message with the name this scrip was invoked with.
	notify-send --app-name "${0##*/}" "$out_summary" "$out_body"
}

# Debug with static file.
if [ -n "$1" ]; then
	parse_send "debugmail"  "$1"
	exit 0
fi

# Let inotifywait monitor changes and output each event on it's own line.
while read mail; do
	# Split inotify output to get path and the file that was added.
	parts=($(echo "$mail" | sed -e 's/ \(CREATE\|MOVED_TO\) / /'))
	inbox_path="${parts[0]}"
	inbox=$(echo "$inbox_path" | grep -Po "(?<=/)\w+(?=/new)")
	mailfile="${parts[1]}"
	parse_send "$inbox"  "${inbox_path}/${mailfile}"
done < <(inotifywait --monitor --event create --event moved_to ${watchdirs} 2>/dev/null)
