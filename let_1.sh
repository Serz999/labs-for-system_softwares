#!/bin/bash

code(){
	arr=()
        while read -n 1 c; do arr+=($c); done  <<< "$arg"
        for digit in ${arr[@]};{
		digit_bin=()
                #convert digit to bin
                for((i=0; digit >= 2; i++));{
                        digit_bin[$i]=$(($digit % 2))
                        digit=$(($digit / 2))
                }
                size=${#digit_bin[@]}
                if ((digit == 0));then
                        digit_bin[$size]=0
                else
                        digit_bin[$size]=1
                fi

                #add k= "0" and one "1"
                size=${#digit_bin[@]}
                digit_bin[$size]=1
                k=$size-1
                for((i=size+1; i < size+k+1; i++));{
                        digit_bin[$i]=0
                }

                #array reverse
                size=${#digit_bin[@]}
                end=$(($size-1))
                tmp=0
                for((i=0; i < size/2; i++));{
                        tmp=${digit_bin[$i]}
                        digit_bin[$i]=${digit_bin[$end]}
                        digit_bin[$end]=$tmp
                        end=$(($end-1))
                }
		for((i=0; i < ${#digit_bin[@]}; i++));{
			outcode+=${digit_bin[$i]}
		}
        }
        code_res=$outcode
}

decode(){
	arr=()
	while read -n 1 c; do arr+=($c); done  <<< "$arg"
	i=0
	arg_size=${#arr[@]}
	while ((i < arg_size));do
		#count the bits to read
		bit_count=1
		while ((${arr[$i]} != 1));do
			bit_count=$(($bit_count + 1))
			i=$(($i + 1))
		done
		i=$(($i + 1))
		
		#read the bits and conver in decimal number
		border_idx=$(($bit_count + $i))
		bit_idx=$(($bit_count - 1))
		dec_num=0
		while ((i < border_idx));do
			if ((${arr[$i]} == 1));then
				num=1
				for((j=0; j < bit_idx; j++));do
					num=$(($num * 2))		
				done
				dec_num=$(($dec_num + $num))
			fi
			i=$(($i + 1))
			bit_idx=$(($bit_idx - 1))
		done
		outdecode+=$dec_num
	done
	decode_res=$outdecode
}

#test code function
arg=$1
code $arg
echo $code_res

#test decode function
arg=$code_res
decode $arg
echo $decode_res

exit 0
