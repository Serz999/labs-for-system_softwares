#!/bin/bash

#check arguments count
if (($# != 1)); then
	echo "error: the script expects a single integer as an argument!"
	exit 0
fi

#read the argument like array
while read -n 1 c;do
       	number+=($c)
done  <<< "$1"

#check input arguments
digits='[0-9]'
for ((i=0; i < ${#number[@]}; i++));do
        if ! [[ ${number[$i]} =~ $digits ]];then
                echo "[$i] => '${number[i]}' is not a digit!"
                echo "error: string \"$1\" must be in [0-9] range"
                exit 0
        fi
done

#find minimal digit with minimal index
min_digit=${number[0]}
min_index=0
for((i = 1; i < ${#number[@]}; i++)); do
	if [[ ${number[$i]} < $min_digit ]]; then
		min_digit=${number[$i]}
		min_index=$i
	fi
done

#output minimal number with the only one swap operation
echo -n "smallest($1) --> [$min_digit"

for ((i = 0; i < ${#number[@]}; i++)); do
    if [ $i != $min_index ]; then
        echo -n "${number[$i]}"
    fi
done

echo -n ", $min_index, 0]"

echo

exit 0
