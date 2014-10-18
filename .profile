# Erik Westrups's bash profile.
# This file is read each time a login shell is started.  All other interactive shells will only read .bashrc; this is particularly important for language settings.

# Read global configuration.
if [ -f /etc/profile ]; then
	. /etc/profile 
fi

#export LANG=en_US.UTF-8	# American program output. Overrides $RC_LANG from /etc/sysconfig/language.

# Fortune cookies!
if [ -x /usr/bin/fortune ] ; then
    echo
    /usr/bin/fortune
    echo
fi

# Load custom keymap
# NOTE allow me or %wheeler to issue loadkeys with no password.
if [ -f "$HOME/.keymap" ]; then
	sudo loadkeys -q $HOME/.keymap &>/dev/null
fi

# Start SSH agent.
#SSHAGENT=/usr/bin/ssh-agent
#SSHAGENTARGS="-s"
#if [ -z "$SSH_AUTH_SOCK" -a -x "$SSHAGENT" ]; then
	#eval `$SSHAGENT $SSHAGENTARGS` &>/dev/null
	#trap "kill $SSH_AGENT_PID" 0
#fi

# Source bashrc. Most of the settings there are relevant also for login shells.
if [ -f $HOME/.bashrc ]; then
    . $HOME/.bashrc
fi
