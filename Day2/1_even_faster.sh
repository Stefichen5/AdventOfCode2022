#!/bin/bash


INPUT=$1

if [ -z "$INPUT" ] ; then
	echo "Please give input file as parameter"
	exit 1
fi

# A X => Tie, 3 + 1 Rock
# A Y => Win, 6 + 2 Paper
# A Z => Loose, 3 Scissors
# B X => Loose, 1 Rock
# B Y => Tie, 3 + 2 Paper
# B Z => Win, 6 + 3 Scissors
# C X => Win, 6 + 1 Rock
# C Y => Loose, 2 Paper
# C Z => Tie, 3 + 3 Scissors

echo $(( $(sort "$INPUT" | uniq -c | sed -e 's/A X/4/g' \
	-e 's/A Y/8/g' -e 's/A Z/3/g' -e 's/B X/1/g' -e 's/B Y/5/g' \
	-e 's/B Z/9/g' -e 's/C X/7/g' -e 's/C Y/2/g' -e 's/C Z/6/g' \
	| awk '{$1=$1;print}' | sed -e 's/ /*/g' | tr '\n' '+' | sed -e 's/+$/\n/g')))
