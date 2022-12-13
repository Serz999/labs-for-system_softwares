#!/bin/bash

echo "ENTER THE COMMAND"
echo "1 -> disk space status"
echo "2 -> folder size"
echo "3 -> hostname"
echo "4 -> system running time"
echo "0 -> exit"

while [ 1 ]
do
read arg
if [[ $arg == 0 ]]
then
break
fi
if [[ $arg == 1 ]] || [[ $arg == 2 ]] || [[ $arg == 3 ]] || [[ $arg == 4 ]]
then
case $arg in
"1")echo "disk space status: ";df -h;; 
"2")echo "folder size: ";du -sh /home;;
"3")echo "hostname is: ";hostname;;
"4")echo "system running time is: ";uptime;;
esac
else
echo "unknown command!" 
fi
done

exit 0
