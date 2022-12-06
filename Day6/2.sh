#!/bin/bash

function pop_first(){
	BUF="${BUF:1}"
}

function append_buff(){
	BUF="${BUF}${1}"
}

#Ret: 0 = no duplicates, 1 = duplicates
function buf_has_no_duplicates(){
	local RET=0
	echo "$BUF" | grep -q '\(.\).*\1'
	RET=$?
	return $RET
}

INPUT=$1

if [ -z "$INPUT" ] ; then
	echo "Please give input file as parameter"
	exit 1
fi

IN_STRING=$(cat "$INPUT")

BUF="${IN_STRING:0:13}"


for (( i=13; i<${#IN_STRING}; i++ )); do
	CUR_CHAR="${IN_STRING:$i:1}"

	#check if string contains duplicates -> can not be sequence
	append_buff "${CUR_CHAR}"
	buf_has_no_duplicates
	DUPL=$?

	if [ $DUPL -eq 0 ]; then
		#Contains substring.
		pop_first
	else
		echo $((i+1))
		exit
	fi
done
