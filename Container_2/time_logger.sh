#!/bin/bash

logfile="var/log/time.log"

while (true);do
	message=`date +%H:%M:%S`
	echo $message >> $logfile
	sleep 5
done

exit 0
