#!/bin/bash
 
result_string=$1$2

#check arguments
#create eq letters array
while read -n 1 c;do
arg_arr+=($c)
done  <<< "$result_string"

letters='[a-z]'
for ((i=0; i < ${#arg_arr[@]}; i++));do
	if ! [[ ${arg_arr[$i]} =~ $letters ]];then
        	echo "[$i] => '${arg_arr[i]}' is not a letter!"
                echo "error: string \"$1\" must be in [a-z] range"
                exit 0
        fi
done

#sort eq letters array 
IFS=$'\n' sort_str_arr=($(sort <<<"${arg_arr[*]}"))

#write values to string
result_string=$( IFS=$''; echo "${sort_str_arr[*]}" )

#output with removing excess letters
echo "$result_string" | tr -s 'a-z'

exit 0
