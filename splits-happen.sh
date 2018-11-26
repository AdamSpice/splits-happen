#!/bin/bash
# Adam Spice - 20181126
# Script to calculate bowling score based on a user-provided string
#

if [[ "$1" == '-h' ]] ; then
	echo "Usage: $0 [....................]"
	echo 'Accept a string of up to 20 characters to calculate a total bowling score.'
	echo 'The score may optionally be provided on the command line. If you run the script without arguments, you will be prompted.'
	echo 'The script will interpret an "X" as a strike, a "/" as a spare, and a "-" as a miss. Numbers are simply pins knocked down.'
	echo 'Examples: '
	echo -e "\tAll strikes: $0 XXXXXXXXXX"
	echo -e "\tMixed results: $0 X7/9-X-88/-6XXX81"
	echo -e "\tPrompt for score: $0"
	echo
	echo 'Happy bowling!'
	echo
	exit
fi

# Take score from invocation or prompt for it if not present
if [[ -n "$1" ]] ; then
	scores="$1"
else
	echo 'What was your score?'
	echo 'An "X" will be interpreted as a strike, a "/" as a spare, and a "-" as a miss. Numbers are pins knocked down.'
	echo -n 'Please enter your scores: '
	read scores
fi

running_count='0'
turns=0

# Iterate a number of times matching the length of the string 
for (( i=0; i<${#scores}; i++ )); do

	# Only ten frames permitted - number of turns may vary
	if [[ $turns -gt 19 ]] ; then break ; fi

	# Parse string to build score equation
	if [[ ${scores:$i:1} == '/' ]] ; then
		# spare! score is 10 + next roll
		running_count="$(echo ${running_count} | sed 's/+[0-9]\{1,2\}$//')+10+${scores:$(($i+1)):1}"
		let turns=$turns+1
	elif [[ ${scores:$i:1} == 'X' ]] ; then
		# strike! score is 10 + next 2 rolls
		change="+${scores:$i:1}+${scores:$(($i+1)):1}+${scores:$(($i+2)):1}"
		if echo $change | grep -q '/' ; then
			# if a spare is in the next two rolls, they are 10 together
			change=+${scores:$i:1}+10
		fi
		running_count="${running_count}${change}"
		let turns=$turns+2
	else
		# Score is number of pins knocked down
		running_count="$running_count+${scores:$i:1}"
		let turns=$turns+1
	fi

	# uncomment line below to see total score so far
	# echo "The score so far is ${running_count}"
done

# Replace symbols and letters in running_count with meaningful values
score_math="$(echo $running_count | sed -E -e 's/X/10/g' -e 's/\+?-//g')"

# uncomment line below to verify math
# echo $score_math

# calculate and output final score
echo "Your final score was $(( $score_math ))."
