#!/bin/bash

#ASCII range 97 ~ 122

letter_sum(){
	#arguments count check
	if(($# == 0));then
		echo "z"
	else

	let_sum=0
	for par in $*;do
		#current argument size check
		if ((${#par} > 1));then
			echo "throw: argument \"$par\"  must be a single letter!"
			exit 1
		fi

		ascii_let=$(printf '%d\n' "'$par")
		let_num=$(($ascii_let-96))
		let_sum=$(($let_sum+$let_num))	
	done

	while((let_sum>26));do
		let_sum=$(($let_sum-26))
	done

	ascii_res=$(($let_sum+96))
	letter=$(printf "\x$(printf %x $ascii_res)")
	echo $letter
	fi
}

letter_sum $*

exit 0
