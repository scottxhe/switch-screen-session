#! /bin/bash

ss() {
	if [ -z $1 ]; then
		screen -ls
		return 0
	fi

	next_session=$1
	prev_session=$1

	if [ -z "$STY" ]; then

		if [ ! -e ~/.next_s ]; then
			mkfifo ~/.next_s
		fi

		if [ ! -e ~/.prev_s ]; then
			mkfifo ~/.prev_s
		fi

		(
		    echo $next_session > ~/.next_s &
			echo $prev_session > ~/.prev_s &
		)

		while true; do
			next="$(cat ~/.next_s)"
			prev="$(cat ~/.prev_s)"

			if [ -z "$next" ] && [ -z "$prev" ]; then
				return 0
			elif grep -q "^~" <<< "$prev"; then
				next_session=$prev_session
				prev_session="$(sed s/~// <<<"$prev" | grep -v "^$")"
			else
				prev_session=$prev
				next_session=$(grep -v "^$" <<< "$next")
			fi

			screen -dR $next_session

			(
				echo '' > ~/.next_s &
				echo '' > ~/.prev_s &
			)
		done
	else
		(
			echo $next_session > ~/.next_s &
			echo $STY > ~/.prev_s &
		)

		screen -d $STY
	fi
}

st() {
	(echo "~$STY" > ~/.prev_s &)
	screen -d $STY
}

_switch_session_autocomplete() {
 local cur
 COMPREPLY=()
 cur=${COMP_WORDS[COMP_CWORD]}
 sessions=$(tr '\n' ' ' <<< $(screen -ls | grep -oE  [[:space:]][0-9]\+\.[^[:blank:]]* | grep -oE [^.]*$))
 COMPREPLY=( $(compgen -W "${sessions}" -- ${cur}) )
 return 0
}

complete -o nospace -F _switch_session_autocomplete ss
