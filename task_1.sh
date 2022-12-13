#!/bin/bash

declare -a arr_words="( $1 )"
echo ${arr_words[@]}
size=${#arr_words[@]}
tmp=0
end_idx=$((size-1))

for((i=0; i<size/2; i++))
{
	tmp=${arr_words[$i]}
	arr_words[$i]=${arr_words[$end_idx]}
	arr_words[$end_idx]=$tmp
	end_idx=$(($end_idx-1))
}

echo ${arr_words[@]}
exit 0
