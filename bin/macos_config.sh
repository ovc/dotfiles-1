#!/usr/bin/env sh

# Change screenshot destination from Desktop to something sane.
defaults write com.apple.screencapture location $HOME/media/images/screenshots

# Enable locate(1).
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist
# Build its database.
sudo /usr/libexec/locate.updatedb
