#!/bin/bash


INPUT=$1

if [ -z "$INPUT" ] ; then
	echo "Please give input file as parameter"
	exit 1
fi

# A=X=rock
# B=Y=paper
# C=Z=scissors

SCORE_ROCK="1"
SCORE_PAPER="2"
SCORE_SCISSORS="3"
WIN_BONUS="6"
TIE_BONUS="3"
TOTAL_SCORE="0"

IFS=$'\n'

LINES=$(sort "$INPUT" | uniq -c)

for line in $LINES ; do
	line=$(echo "$line" | xargs)
	NR_OF_OCCURENCES="$(echo "$line" | cut -d' ' -f1)"
	OPPONENT="$(echo "$line" | cut -d' ' -f2)"
	ME="$(echo "$line" | cut -d' ' -f3)"
	ADD_PTS="0"

	#calculate points for using rock/paper/scissor

	if [ "$ME" == "X" ] ; then
		ADD_PTS=$SCORE_ROCK
	elif [ "$ME" == "Y" ] ; then
		ADD_PTS=$SCORE_PAPER
	elif [ "$ME" == "Z" ] ; then
		ADD_PTS=$SCORE_SCISSORS
	fi
	TOTAL_SCORE=$((TOTAL_SCORE + NR_OF_OCCURENCES * ADD_PTS))

	#calculate win, tie or loose
	if { [ "$OPPONENT" == "A" ] && [ "$ME" == "Y" ]; } \
		|| { [ "$OPPONENT" == "B" ] && [ "$ME" == "Z" ]; } \
		|| { [ "$OPPONENT" == "C" ] && [ "$ME" == "X" ]; } ; then
		TOTAL_SCORE=$((TOTAL_SCORE + NR_OF_OCCURENCES * WIN_BONUS))
	elif { [ "$OPPONENT" == "A" ] && [ "$ME" == "X" ]; } \
		|| { [ "$OPPONENT" == "B" ] && [ "$ME" == "Y" ]; } \
		|| { [ "$OPPONENT" == "C" ] && [ "$ME" == "Z" ]; } ; then
		TOTAL_SCORE=$((TOTAL_SCORE + NR_OF_OCCURENCES * TIE_BONUS))
	fi
done <"$INPUT"

echo $TOTAL_SCORE
