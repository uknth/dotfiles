#!/bin/bash

if [ -d /etc/profile.d ]; then
	for i in /etc/profile.d/*.sh; do
		if [ -r $i ]; then
			. $i
		fi
	done
	unset i
fi

# Set up Environment Variables
DOT_OS="$(fn_operating_system)"
DOT_HOME="$dot_home"
DOT_DATA="$dot_data"

# Git Config
git config --global url."git@github.com:".insteadOf "https://github.com/"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
	export PATH="$HOME/.local/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
	export PATH="$HOME/bin:$PATH"
fi

export PATH="$dot_home/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"
