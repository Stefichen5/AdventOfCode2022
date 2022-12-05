#!/bin/bash

function dump_crate(){
	echo "---------------------------"
	for elem in "${STACK_PREPARED_ROTATED[@]}" ; do
		echo "$elem"
	done
}

function dump_password(){
	PW=""
	for elem in "${STACK_PREPARED_ROTATED[@]}" ; do
		PW="${PW}${elem: -1}"
	done
	echo "$PW"
}

function move_crate(){
	local MOVE_FROM="$1"
	local MOVE_TO="$2"

	#because our array starts at 0, but our counting at 1
	MOVE_FROM=$((MOVE_FROM-1))
	MOVE_TO=$((MOVE_TO-1))

	if [ -z "${STACK_PREPARED_ROTATED[$MOVE_FROM]}" ] ; then
		return
	fi

	MOVE_CHAR=${STACK_PREPARED_ROTATED[$MOVE_FROM]: -1} #get top element
	STACK_PREPARED_ROTATED[$MOVE_FROM]="${STACK_PREPARED_ROTATED[$MOVE_FROM]:0:-1}" #remove top element from old position
	STACK_PREPARED_ROTATED[$MOVE_TO]="${STACK_PREPARED_ROTATED[$MOVE_TO]}${MOVE_CHAR}" #append it to new position
}

INPUT=$1

if [ -z "$INPUT" ] ; then
	echo "Please give input file as parameter"
	exit 1
fi

IFS=$'\n'

STACK="$(grep '\[' "$INPUT")"
INSTRUCTIONS="$(grep "move" "$INPUT")"

CNT=0

STACK_PREPARED=("")
STACK_PREPARED_ROTATED=("")

for elem in $STACK ; do
	elem=${elem//    /[ ]}
	STACK_PREPARED[$CNT]=$(echo "$elem" | sed -e 's/\]\[/\] \[/g' -e 's/\[ \]/\[?\]/g' -e 's/\[//g' -e 's/\]//g' -e 's/ //g')
	CNT=$((CNT+1))
done

for elem in "${STACK_PREPARED[@]}" ; do
	for (( i=0; i<${#elem}; i++ )); do
		STACK_PREPARED_ROTATED[$i]="${elem:$i:1}${STACK_PREPARED_ROTATED[$i]}"
		STACK_PREPARED_ROTATED[$i]=${STACK_PREPARED_ROTATED[$i]//\?/}
	done
done

for instruction in $INSTRUCTIONS ; do
	MOVE_CNT="$(echo "$instruction" | cut -d' ' -f2)"
	FROM="$(echo "$instruction" | cut -d' ' -f4)"
	TO="$(echo "$instruction" | cut -d' ' -f6)"

	for ((i = 0 ; i < "$MOVE_CNT" ; i++)) ; do
		move_crate "$FROM" "$TO"
	done
done

dump_password
