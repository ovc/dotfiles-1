#/usr/bin/env sh
# Programs that should be started with each Inglewood KDE session.

# Start fetching mails.
/usr/bin/env offlineimap &

# Start Yakuake and load my tmux session.
/usr/bin/env yakuake
yakuake_sessionID=$(qdbus org.kde.yakuake /yakuake/sessions org.kde.yakuake.activeSessionId)
qdbus org.kde.yakuake /yakuake/tabs setTabTitle $yakuake_sessionID "irctor"
qdbus org.kde.yakuake /yakuake/sessions runCommandInTerminal $yakuake_sessionID "irctor attach"

# Start my browser, takes a while to load.
/usr/bin/env firefox &

# Start Skype and skyped served.
/usr/bin/env skype &
(sleep 20s && /usr/bin/skyped) &

# Start my clipboard manager.
/usr/bin/env parcellite &

# Start mailleds that will blink LEDs when there are unread emails.
$HOME/bin/mailleds_start.sh

# Start irexec used for executing arbitary commands from ~/.lircrc.
/usr/bin/env irexec --daemon

# Start dropbox sync.
/usr/bin/env dropbox start -i

# Start notify-listener to the irssi plugin notify can emit messages.
# NOTE stoped working, missing typelibe, so the legacy notify-send is used directly in the irssi plugin instead.
#$HOME/bin/notify-listener.py

# Scrobble songs in MPD.
/usr/bin/env mpdscribble

# Notify MPD song changes.
/usr/bin/env mpdknotifier &

# Start X keyboard shortcut daemon.
/usr/bin/env xbindkeys

exit 0
