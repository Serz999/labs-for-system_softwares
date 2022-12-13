#!/bin/bash

echo -n "enter your text: "
read arg

declare -a text="( $arg )"

echo -n "shift is: "
read _shift

#check input argument
re='^[0-9]+$'
if ! [[ $_shift =~ $re ]] ; then
        echo "error: shift must be a number!"
        exit 1
fi

letter_small='[a-z]'
letter_big='[A-Z]'
num='[0-9]'

global_idx=0
for ((i=0; i < ${#text[@]}; i++));do
	elem_arr=()
	while read -n 1 c;do 
		elem_arr+=($c) 
	done  <<< "${text[$i]}"
	for ((j=0; j < ${#elem_arr[@]}; j++));do
		if [[ ${elem_arr[$j]} =~ $letter_small ]] || [[ ${elem_arr[$j]} =~ $letter_big ]] ;then
			#char to int
                        ascii_let=$(printf '%d\n' "'${elem_arr[$j]}")
                	let_num=$(($ascii_let - 96))
                	let_shifting=$(($let_num + $_shift))
			#overload handling
			brake_condition=26
			if [[ ${elem_arr[$j]} =~ $letter_big ]];then
				brake_condition=-6
			fi
        		while ((let_shifting > brake_condition));do
                		let_shifting=$(($let_shifting - 26))
        		done
			#int to char
        		ascii_res=$(($let_shifting + 96))
        		res=$(printf "\x$(printf %x $ascii_res)")
			#assign final char value
    			elem_arr[$j]=$res
		elif [[ ${elem_arr[$j]} =~ $num ]] ;then
			#if symbol in str is num
			elem_arr[$j]=$((9 - ${elem_arr[$j]}))
                fi
		#changing the case of letters
		if ((global_idx%2 == 0));then
			elem_arr[$j]=$(echo ${elem_arr[$j]} | tr '[:lower:]' '[:upper:]')
		else
			elem_arr[$j]=$(echo ${elem_arr[$j]} | tr '[:upper:]' '[:lower:]')
		fi	
		global_idx=$(($global_idx + 1))
	done
	global_idx=$(($global_idx + 1))
	#write result to string value
	text[$i]=""
	for symbol in ${elem_arr[@]};do
		text[$i]+=$symbol
	done
done

#reverse the array of string
size=${#text[@]}
tmp=0
end_idx=$((size-1))
for((i=0; i<size/2; i++));do
       	tmp=${text[$i]}
        text[$i]=${text[$end_idx]}
        text[$end_idx]=$tmp
        end_idx=$(($end_idx-1))
done

#reverse the strings in array
for ((i=0; i < ${#text[@]}; i++));do
	elem_arr=()
        while read -n 1 c;do 
		elem_arr+=($c) 
	done  <<< "${text[$i]}"
	size=${#elem_arr[@]}
	tmp=0
	end_idx=$((size-1))
	for((j=0; j<size/2; j++));do
        	tmp=${elem_arr[$j]}
        	elem_arr[$j]=${elem_arr[$end_idx]}
        	elem_arr[$end_idx]=$tmp
        	end_idx=$(($end_idx-1))
	done
	text[$i]=""
        for symbol in ${elem_arr[@]};do
                text[$i]+=$symbol
        done
done

echo ${text[@]}

exit 0
