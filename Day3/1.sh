#!/bin/bash

INPUT=$1

if [ -z "$INPUT" ] ; then
	echo "Please give input file as parameter"
	exit 1
fi

function lookup(){
	if [ "$1" == 'a' ] ; then
		return 1
	elif [ "$1" == 'b' ] ; then
		return 2
	elif [ "$1" == 'c' ] ; then
		return 3
	elif [ "$1" == 'd' ] ; then
		return 4
	elif [ "$1" == 'e' ] ; then
		return 5
	elif [ "$1" == 'f' ] ; then
		return 6
	elif [ "$1" == 'g' ] ; then
		return 7
	elif [ "$1" == 'h' ] ; then
		return 8
	elif [ "$1" == 'i' ] ; then
		return 9
	elif [ "$1" == 'j' ] ; then
		return 10
	elif [ "$1" == 'k' ] ; then
		return 11
	elif [ "$1" == 'l' ] ; then
		return 12
	elif [ "$1" == 'm' ] ; then
		return 13
	elif [ "$1" == 'n' ] ; then
		return 14
	elif [ "$1" == 'o' ] ; then
		return 15
	elif [ "$1" == 'p' ] ; then
		return 16
	elif [ "$1" == 'q' ] ; then
		return 17
	elif [ "$1" == 'r' ] ; then
		return 18
	elif [ "$1" == 's' ] ; then
		return 19
	elif [ "$1" == 't' ] ; then
		return 20
	elif [ "$1" == 'u' ] ; then
		return 21
	elif [ "$1" == 'v' ] ; then
		return 22
	elif [ "$1" == 'w' ] ; then
		return 23
	elif [ "$1" == 'x' ] ; then
		return 24
	elif [ "$1" == 'y' ] ; then
		return 25
	elif [ "$1" == 'z' ] ; then
		return 26
	fi
	echo "fail"
}

TOTAL_SCORE="0"

while IFS= read -r line
do
	FIRST="${line:0:${#line}/2}"
	SECOND="${line:${#line}/2}"

	FIRST_SORTED_UNIQUE="$(echo "$FIRST" | grep -o . | sort -u | tr -d '\n')"
	SECOND_SORTED_UNIQUE="$(echo "$SECOND" | grep -o . | sort -u | tr -d '\n')"

	for (( i=0; i<${#FIRST_SORTED_UNIQUE}; i++ )) ; do
		CHAR="${FIRST_SORTED_UNIQUE:$i:1}"
		DUPL="$(echo "$SECOND_SORTED_UNIQUE" | grep "$CHAR")"
		if [ -n "$DUPL" ] ; then
			OFFSET=0
			if [[ $CHAR =~ [A-Z] ]] ; then
				OFFSET=26
				CHAR=$(echo "$CHAR" | tr '[:upper:]' '[:lower:]')
			fi
			lookup "$CHAR"
			TO_ADD=$?
			TOTAL_SCORE=$((TOTAL_SCORE + TO_ADD + OFFSET))
		fi
	done

done < "$INPUT"

echo $TOTAL_SCORE
