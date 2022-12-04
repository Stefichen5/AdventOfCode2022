#!/bin/bash

INPUT=$1

if [ -z "$INPUT" ] ; then
	echo "Please give input file as parameter"
	exit 1
fi

CNT=0

while IFS= read -r line
do
	FIRST=$(echo "$line" | cut -d',' -f1)
	SECOND=$(echo "$line" | cut -d',' -f2)

	FIRST_A=$(echo "$FIRST" | cut -d'-' -f1)
	FIRST_B=$(echo "$FIRST" | cut -d'-' -f2)

	SECOND_A=$(echo "$SECOND" | cut -d'-' -f1)
	SECOND_B=$(echo "$SECOND" | cut -d'-' -f2)

	if { [ "$FIRST_A" -ge "$SECOND_A" ] && [ "$FIRST_B" -le "$SECOND_B" ] ; } \
		|| { [ "$SECOND_A" -ge "$FIRST_A" ] && [ "$SECOND_B" -le "$FIRST_B" ] ; } ; then
		CNT=$((CNT+1))
	fi
done < "$INPUT"

echo $CNT