# .bashrc

# Check for macOS
if [ "$(uname)" = "Darwin" ]; then
	mac=1
fi

# Source global definitions
if [ "$0" = "bash" ] && [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc

export EDITOR=vim
export GPG_TTY="$(tty)"
if [ $mac ]; then
	export PINENTRY_USER_DATA="/Applications/MacPorts/pinentry-mac.app/Contents/MacOS/pinentry-mac"
	export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
	gpgconf --launch gpg-agent
else
	export PINENTRY_USER_DATA="/usr/bin/pinentry-gnome3"
	export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
	gpg-connect-agent updatestartuptty /bye > /dev/null
fi

private="$HOME/dotfiles.private/.bashrc"
if [ -f "$private" ]; then
	. $private
fi

cargo="$HOME/.cargo/env"
if [ -f "$cargo" ]; then
	. $cargo
fi
export CARGO_EMAIL=$EMAIL
