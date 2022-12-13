#!/bin/bash

size=$1

#check the arguments
re='^[0-9]+$'
if ! [[ $size =~ $re ]] ; then
	echo "error: argument must be a number!"
	exit 1
fi

#print up section
for((i=0; i < (size*2 - 1)/2; i++));do
	for((j=0; j < size - 1 - i; j++));do
		echo -n " "
        done
	for((j=0; j < i + 1; j++));do
                echo -n ". "
        done
	echo ""
done

#print middle section
for((j=0; j < size; j++));do
        echo -n ". "
done

echo ""

#print down section
for((i=0; i < (size*2 - 1)/2; i++));do
        for((j=0; j < i + 1; j++));do
                echo -n " "
        done
        for((j=0; j < size - 1 - i; j++));do
                echo -n ". "
        done
        echo ""
done

exit 0
