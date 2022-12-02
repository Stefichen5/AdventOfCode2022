#!/bin/bash


INPUT=$1

if [ -z "$INPUT" ] ; then
	echo "Please give input file as parameter"
	exit 1
fi

# A X => Loose, 3 Scissors
# A Y => Tie, 3 + 1 Rock
# A Z => Win, 6 +  2 Paper
# B X => Loose, 1 Rock
# B Y => Tie, 3 + 2 Paper
# B Z => Win, 6 + 3 Scissors
# C X => Loose 2 Paper
# C Y => Tie, 3 + 3 Scissors
# C Z => Win, 6 + 1 Rock

echo $(( $(sort "$INPUT" | uniq -c | sed -e 's/A X/3/g' \
	-e 's/A Y/4/g' -e 's/A Z/8/g' -e 's/B X/1/g' -e 's/B Y/5/g' \
	-e 's/B Z/9/g' -e 's/C X/2/g' -e 's/C Y/6/g' -e 's/C Z/7/g' \
	| awk '{$1=$1;print}' | sed -e 's/ /*/g' | tr '\n' '+' | sed -e 's/+$/\n/g')))
