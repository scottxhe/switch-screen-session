#! /bin/bash

ss() {
	next_session=$1

	if [ -z "$STY" ]; then

		if [ ! -e ~/.next_s ]; then
			mkfifo ~/.next_s
		fi

		echo $next_session > ~/.next_s &

		while true; do
			next="$(cat ~/.next_s)"

			if [ -z "$next" ]; then
				return 0
			else
				screen -dR $(grep -v "^$" <<< "$next")
				echo '' > ~/.next_s &
			fi
		done
	else
		echo $next_session > ~/.next_s &
		screen -d $STY
	fi
}

sls() {
    screen -ls
}

sn() {
    echo "$STY"
}

_switch_session_autocomplete()
{
 local cur
 COMPREPLY=()
 cur=${COMP_WORDS[COMP_CWORD]}
 sessions=$(tr '\n' ' ' <<< $(screen -ls | grep -oE  [[:space:]][0-9]\+\.[^[:blank:]]* | grep -oE [^.]*$))
 COMPREPLY=( $(compgen -W "${sessions}" -- ${cur}) )
 return 0
}

complete -o nospace -F _switch_session_autocomplete ss
