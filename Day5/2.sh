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

function move_crates(){
	local MOVE_CNT="$1"
	local MOVE_FROM="$2"
	local MOVE_TO="$3"

	#because our array starts at 0, but our counting at 1
	MOVE_FROM=$((MOVE_FROM-1))
	MOVE_TO=$((MOVE_TO-1))

	if [ -z "${STACK_PREPARED_ROTATED[$MOVE_FROM]}" ] ; then
		return
	fi

	MOVE_CHARS=${STACK_PREPARED_ROTATED[$MOVE_FROM]: -${MOVE_CNT}} #get top element
	STACK_PREPARED_ROTATED[$MOVE_FROM]="${STACK_PREPARED_ROTATED[$MOVE_FROM]:0:-${MOVE_CNT}}" #remove top element from old position
	STACK_PREPARED_ROTATED[$MOVE_TO]="${STACK_PREPARED_ROTATED[$MOVE_TO]}${MOVE_CHARS}" #append it to new position
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

	move_crates "$MOVE_CNT" "$FROM" "$TO"
done

dump_password
