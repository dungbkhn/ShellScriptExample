#!/bin/bash

#danh cho append file

shopt -s dotglob
shopt -s nullglob
 
dir_ori=/home/dungnt/ShellScript/dirtest1
dir_dest=/home/dungnt/ShellScript/dirtest2
mem_temp=/home/dungnt/ShellScript/temp

copyfilesize="1KB"
truncsize=1000
countsize=0
skipsize=0

verify_logged() {
	#mac dinh la ko thay active user 
	local kq
	local findresult
	local cmd
	local line
	local value
	local curtime
	local delaytime
	
	kq=0
	
	netstat -atn | grep ':22' | grep 'ESTABLISHED'
	cmd=$?
	
	#neu ko tim thay co active connection 
	if [ "$cmd" -eq 1 ] ; then
		findresult=$(find "$mem_temp" -type f -name "$logtimefile")
		cmd=$?
		
		#echo $?
		#printf 'findresult:%s\n' "$findresult"
		
		#neu tim thay file
		if [ "$cmd" -eq 0 ] && [ "$findresult" ] ; then
			#printf 'here:%s' "$findresult"
			while IFS= read -r line
			do
			  value="$line"
			done < "$mem_temp"/"$logtimefile"
			
			curtime=$(($(date +%s%N)/1000000))
			#printf 'curtime:%s\n' "$curtime"

			delaytime=$(( ( $curtime - $value ) / 60000 ))
			#printf 'delaytime:%s\n' "$delaytime"" minutes"
			if [ "$delaytime" -gt 5 ] ; then
				#ko thay active user
				kq=255
				rm "$mem_temp"/"$logtimefile"
			else
				#tim thay co active user
				kq=1
			fi
		else
			#ko thay active user's logfile
			kq=254
		fi
	else
		#tim thay co active connection 
		kq=0
	fi

	return "$kq"
}

copy_partial_file() {
	local param1=$1
	local param2=$2
	local param3=$3
	
	printf 'copy:%s to %s\n' "$param1" "$param2"
	#dd if=./listdir.sh of=./out.sh bs=1c count=5 skip=3
	filesize=$(wc -c "$param1" | awk '{print $1}')
	filesize=$(($filesize / $truncsize))
	printf 'filesize:%s\n' "$filesize"
	mycommand="rm ""$mem_temp""/""*"
	cursize=0
	
	while [ $cursize -lt $filesize ]
	do
		echo $mycommand
		eval $mycommand
		
		#printf 'dd:%s to %s\n' "$param1" "$mem_temp""/""$param3"
		dd if="$param1" of="$mem_temp""/""output.beingcopy" bs="$copyfilesize" count=1 skip="$cursize"
		if [ $cursize -eq 0 ]
			then
				cp "$mem_temp""/""output.beingcopy" "$param2""$param3"
			else
				cat "$mem_temp""/""output.beingcopy" >> "$param2""$param3"
		fi
		
		mycommand="rm ""$mem_temp""/""output.beingcopy"
		cursize=$(($cursize + 1))
		echo $cursize
		
		#test
		if [ $cursize -eq 10 ]
			then
				break
		fi
		#end test
	done
	
}


append_file() {
	local param1=$1
	local param2=$2
	local param3=$3
	local filesizedest
	local cursizedest
	local cursize
	local filesize
	local cmd
	local kq
	
	kq=0
	printf 'append:%s to %s\n' "$param1" "$param2""$param3"
	
	filesizedest=$(wc -c "$param2""$param3" | awk '{print $1}')
	cmd=$?
	
	if [ $cmd == 0 ] && [ $filesizedest ] && [ "$filesizedest" -gt 0 ] ; then
		cursizedest=$(($filesizedest / $truncsize))
		#cursizedest phai lon hon hoac bang 2, xem check_same_file
		cursizedest=$(($cursizedest - 2))
		echo $cursizedest
		
		cursize=$cursizedest
		
		printf 'begin append'
		filesize=$(wc -c "$param1" | awk '{print $1}')
		cmd=$?
		
		if [ $cmd == 0 ] && [ $filesize ] && [ "$filesize" -gt 0 ] ; then
		
			filesize=$(($filesize / $truncsize))
			printf 'filesize:%s\n' "$filesize"

			while [ $cursize -lt $filesize ]
			do
				rm "$mem_temp""/""output.beingcopy"
				
				#printf 'dd:%s to %s\n' "$param1" "$mem_temp""/""$param3"
				dd if="$param1" of="$mem_temp""/""output.beingcopy" bs="$copyfilesize" count=1 skip="$cursize"
				dd if="$mem_temp""/""output.beingcopy" of="$param2""$param3" bs="$copyfilesize" count=1 seek="$cursize"

				cursize=$(($cursize + 1))
				echo $cursize
				
				#verify logged after each loop
				verify_logged
				cmd=$?
				
				#if verifyresult: having active user/connection -> break
				if [ "$cmd" -lt 10 ] ; then
					kq=1
					break
				fi
			done
			
			if [ "$kq" -eq 0 ] ; then
				dd if="$param1" of="$mem_temp""/""output.beingcopy" bs="$copyfilesize" skip="$cursize"
				dd if="$mem_temp""/""output.beingcopy" of="$param2""$param3" bs="$copyfilesize" seek="$cursize"
			fi
		fi
	fi
	
	return "$kq"
}

sync_dir () {
	local param1=$1
	local param2=$2
	printf 'goi de quy voi:%s %s\n' "$param1" "$param2"
    for pathname in "$param1"/*; do
        if [ -d "$pathname" ]; then
			#printf 'dir:%s\n' "$pathname"
			oldbasename="$curbasename"
			#lay ten thu muc
			curbasename=$(basename "$pathname")
			printf 'curbasename:%s\n' "$curbasename"
			echo "mkdir:$dir_dest""$param2""$curbasename""/"
			mkdir "$dir_dest""$param2""$curbasename""/"
            sync_dir "$pathname" "$param2""$curbasename""/"
        else
			curfilename=$(basename "$pathname")
            #copy_partial_file "$pathname" "$dir_dest""$param2" "$curfilename"
            append_file "$pathname" "$dir_dest""$param2" "$curfilename"
        fi
    done
}

sync_dir "$dir_ori" "/"


