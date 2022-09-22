#!/bin/bash


#printf "{\"name\": \"Craig\"}\n" 1>&$NODE_CHANNEL_FD
sleep 0.1m
i=0
#while [ i -lt 10000 ] ; do 
	MESSAGE=read -u $NODE_CHANNEL_FD
	echo " => message from parent process => $MESSAGE" > file.txt
#done



