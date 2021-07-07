#! /bin/bash

NEXT_SESSION_STORAGE_FILE=${HOME}/.ss_next_session

if [ ! -f "$NEXT_SESSION_STORAGE_FILE" ]; then
    touch "$NEXT_SESSION_STORAGE_FILE"
    echo "The Switch Screen Session(ss) command created a file loclated at ${NEXT_SESSION_STORAGE_FILE}"
    echo "Please do not delete this file!!"
fi

ss() {
	SESSION=$1

	if [ -n "$STY" ]; then
	 echo 'Cannot use ss while in a screen session'
	 return 1
	fi

	if [ -z "$SESSION" ]; then
	 echo 'Please specify a new or an existing session'
	 return 1
	fi

        # Initiailize storage
	echo -e '1\n0\n0' > "$NEXT_SESSION_STORAGE_FILE"
    
	while true; do
         if [ $(sed -n 1p "$NEXT_SESSION_STORAGE_FILE") -eq 1 ]; then
	    screen -d -R "$SESSION"
	 else 
	    OUTPUT=$(screen -d -r $SESSION)
            while [ "$?" -eq 1 ]; do
               PREVIOUS_SESSION=$(sed -n 2p "$NEXT_SESSION_STORAGE_FILE")
               OUTPUT=$(screen -S $PREVIOUS_SESSION -X stuff "echo \"${OUTPUT}\"" && screen -d -r $PREVIOUS_SESSION)
            done
	 fi
	 NEXT_SESSION=$(sed -n 3p  "$NEXT_SESSION_STORAGE_FILE")

	 if [  "$NEXT_SESSION" = "0" ]; then
	  break 
	 fi

	 SESSION=$NEXT_SESSION
	update_line_in_file 3 0 "$NEXT_SESSION_STORAGE_FILE"
	done 
}

st() {
	update_line_in_file 1 0 "$NEXT_SESSION_STORAGE_FILE"
    PREVIOUS_SESSION=$(sed -n 2p "$NEXT_SESSION_STORAGE_FILE")
    # Previous session becomes the next session
	update_line_in_file 3 "$PREVIOUS_SESSION" "$NEXT_SESSION_STORAGE_FILE"
	# Current session becomes the previous session
	update_line_in_file 2 "$STY" "$NEXT_SESSION_STORAGE_FILE"
	screen -d
}


si() {
	update_line_in_file 1 0 "$NEXT_SESSION_STORAGE_FILE"
	update_line_in_file 2 "$STY" "$NEXT_SESSION_STORAGE_FILE"
	SESSION=$1

	if [ "$1" == "-c" ]; then
	    SESSION=$2
		update_line_in_file 1 1 "$NEXT_SESSION_STORAGE_FILE"
	fi

	if [ -z "$SESSION" ]; then
           echo 'Please specify a session name' 
	   return 1
	fi

	if [ -z "$STY" ]; then
	 echo 'si must be used while in a screen session'
	 return 1
	fi


	update_line_in_file 3 "$SESSION" "$NEXT_SESSION_STORAGE_FILE"
	screen -d $STY
}

sls() {
    screen -ls
}

sn() {
    echo "$STY"
}

update_line_in_file() {
	LINE=$1
	CONTENT=$2
	FILE=$3
    sed ${LINE}s/.*/"$CONTENT"/ <<< "$(cat $FILE)" > $FILE
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
complete -o nospace -F _switch_session_autocomplete si
