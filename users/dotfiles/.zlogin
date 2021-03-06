# vim:ft=sh

. "$HOME/.zshrc"

export agent_status=$(ps -U $USER | grep 'ssh-agent')

#if [ -f "$XDG_CONFIG_HOME/.energypolicy" ]; then
#	energypolicy $(tail -n 1 "$XDG_CONFIG_HOME/.energypolicy")
#fi

if [ -z "$agent_status" ]; then
	export agent_config=$(ssh-agent)
	export SSH_AUTH_SOCK=$(echo $agent_config | grep -Po "SSH_AUTH_SOCK=\K\S+(?=;)")
fi

if [ -z "$DISPLAY" ] && [ $XDG_VTNR -eq 1 ] && [ "$TERM" != "screen" ]; then
	command -v startx &> /dev/null && exec startx -- -keeptty &> ~/.local/share/xorg/tty.log
elif [ "$TERM" = "linux" ]; then
	sudo kbdrate -s -d 190 -r 100
fi
