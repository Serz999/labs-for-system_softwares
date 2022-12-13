#!/bin/bash

sent=()
i=0
for word in $*;do
	sent[$i]=$word
	i=$(($i + 1))	
done

steps_count=0

for((i = 0; i < ${#sent[@]}; i++));do
	if (( i%2 == 0));then
		if [[ ${#sent[$i]} > ${#sent[$i + 1]} ]];then
			tmp=${sent[$i]}	
			sent[$i]=${sent[$i + 1]}
			sent[$i + 1]=$tmp
			steps_count=$(($steps_count + 1))
		fi
		sent[$i]=$(echo ${sent[$i]} | tr '[:upper:]' '[:lower:]')
	else
                if [[ ${#sent[$i]} < ${#sent[$i + 1]} ]];then
			tmp=${sent[$i]}
			sent[$i]=${sent[$i + 1]}
                        sent[$i + 1]=$tmp
			steps_count=$(($steps_count + 1))
                fi
		sent[$i]=$(echo ${sent[$i]} | tr '[:lower:]' '[:upper:]')
	fi
done

echo ${sent[@]}
echo "#num of steps = \"$steps_count\""

exit 0
