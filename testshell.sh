#!/bin/bash

get_router_baseIP(){
	local IFS
	local strarr
	local len
	local firstelement
	local baseip
	
	
	# Set comma as delimiter
	IFS=':'

	#Read the split words into an array based on comma delimiter
	read -a strarr <<< "$1"

	len=${#strarr[@]}

	len=$(( $len - 1 ))

	firstelement=$(echo "${strarr[0]}" | xargs)

	baseip="$firstelement"":""${strarr[1]}"":""${strarr[2]}"":""${strarr[3]}"
	
	echo "$baseip"
}

#------------------------------------ MAIN ---------------------------------

#printf "Begin\n" > /home/dungnt/routerip.txt

while true ; do

	printf "#-----------------Begin-------------------#\n" > /home/dungnt/routerip.txt
	
	sleep 5

	count=0
	
	routerip=$(traceroute -6 vnexpress.net | grep ' 1 ' |  awk '{print $2}')
	
	if [ "$routerip" ] & [ "$routerip" != "*" ] & [ "$routerip" != "orangepipc" ] ; then
		printf "%s\n" "1 get ipv6 router ok" >> /home/dungnt/routerip.txt
		result=$(get_router_baseIP "$routerip")
	else
		printf "kq1:%s\n" "$routerip" >> /home/dungnt/routerip.txt				
		count=$(( $count + 1 ))
		printf "count:%s\n" "$count" >> /home/dungnt/routerip.txt
	fi 
	
	sleep 5
	
	if [ "$count" -eq 1 ] ; then
	
		routerip=$(traceroute -6 vnexpress.net | grep ' 1 ' |  awk '{print $2}')
		
		if [ "$routerip" ] & [ "$routerip" != "*" ] & [ "$routerip" != "orangepipc" ] ; then
			printf "%s\n" "2 get ipv6 router ok" >> /home/dungnt/routerip.txt
			result=$(get_router_baseIP "$routerip")
		else
			printf "kq2:%s\n" "$routerip" >> /home/dungnt/routerip.txt		
			count=$(( $count + 1 ))
			printf "count:%s\n" "$count" >> /home/dungnt/routerip.txt
		fi 
		
	fi
	
	sleep 5
	
	if [ "$count" -eq 2 ] ; then
	
		routerip=$(traceroute -6 vnexpress.net | grep ' 1 ' |  awk '{print $2}')
		
		if [ "$routerip" ] & [ "$routerip" != "*" ] & [ "$routerip" != "orangepipc" ] ; then
			printf "%s\n" "3 get ipv6 router ok" >> /home/dungnt/routerip.txt
			result=$(get_router_baseIP "$routerip")
		else
			printf "kq3:%s\n" "$routerip" >> /home/dungnt/routerip.txt
			count=$(( $count + 1 ))
			printf "count:%s\n" "$count" >> /home/dungnt/routerip.txt
		fi 
		
	fi
	
	sleep 5
	
	printf "count:%s\n" "$count" >> /home/dungnt/routerip.txt

	#mat network
	if [ "$count" -eq 3 ] ; then
		#trang thai 1
		#echo 'mat mang
		printf "%s\n" "trang thai 1" >> /home/dungnt/routerip.txt
		cp /etc/network/interfaces.auto /etc/network/interfaces
		sleep 60
		/sbin/reboot
	else
		printf "%s\n" "$result" >> /home/dungnt/routerip.txt 
		while IFS= read -r line
		do
		  value="$line"
		  #echo "$value"
		done < /etc/network/interfaces
		
		#/home/dungnt/ShellScript/test13.sh
		#/etc/network/interfaces

		printf "%s\n" "$value" >> /home/dungnt/routerip.txt

		if [ "$value" == "###" ] ; then
			printf "%s\n" "$value" >> /home/dungnt/routerip.txt
		fi
		
		if [ "$value" == "###" ] ; then
			#trang thai 2: co mang voi ipv6 auto
			#echo "trang thai 2 ###"
			printf "%s\n" "trang thai 2" >> /home/dungnt/routerip.txt
			printf "#ipv6 manual config\n" >> /etc/network/interfaces
			printf "auto eth0\n" >> /etc/network/interfaces
			printf "iface eth0 inet6 static\n" >> /etc/network/interfaces
			printf "address ""$result""::e\n" >> /etc/network/interfaces
			printf "netmask 64\n" >> /etc/network/interfaces
			printf "gateway ""$result""::0\n" >> /etc/network/interfaces
			printf "######" >> /etc/network/interfaces
			sleep 60
			/sbin/reboot
		else
			#trang thai 3: co mang voi ipv6 fix
			#echo "trang thai 3 ######"
			printf "%s\n" "trang thai 3" >> /home/dungnt/routerip.txt
		fi
	fi
	
	sleep 15m
done

