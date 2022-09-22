#!/bin/bash

myping(){
	local param1=$1
	local param2=$2
	local cmd
	local kq
	
	if [ "$param1" -ne 6 ] ; then
		ping -c 1 $2
		cmd=$?
		
		if [ "$cmd" -eq 0 ] ; then
			#echo "Host Ipv4 Found"
			kq=1
		else
			#echo "Host Ipv4 Not Found"
			kq=0
		fi
	else
		ping -c 1 -6 $2
		cmd=$?
		
		if [ "$cmd" -eq 0 ] ; then
			#echo "Host Ipv6 Found"
			kq=2
		else
			#echo "Host Ipv6 Not Found"
			kq=0
		fi
	fi
	
	#0: host not found
	#1: host ipv4 found
	#2: host ipv6 found
	return "$kq"
}

main(){
	while true ; do
		myping 6 "2405:4802:254:f80:61ee:65ee:fcac:fcd2"
		#myping 6 "2405:4802:254:f80:9e50:eeff:fee4:da64"
		echo $?
		sleep 0.2m
	done
}

main
