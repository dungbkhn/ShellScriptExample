#!/bin/bash

shopt -s dotglob
shopt -s nullglob
 
dir_ori=/home/dungnt/ShellScript/dirtest1
dir_dest=/home/dungnt/ShellScript/dirtest2
mem_temp=/home/dungnt/ShellScript/temp

curbasename=""
oldbasename=""
copyfilesize="100MB"
truncsize=100000000
countsize=0
skipsize=0

copy_file() {
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
		#if [ $cursize -eq 10 ]
		#	then
		#		break
		#fi
		#end test
	done
	
	#lam lan cuoi
	echo $mycommand
	eval $mycommand
	
	skipsize=$cursize
	cursize=$(($cursize * $truncsize))
	echo $cursize
	filesize=$(wc -c "$param1" | awk '{print $1}')
	countsize=$(($filesize - $cursize))
	
	if [ $countsize -gt 10000000 ]
		then
			printf '10MB:%s\n' "$param1"
			if [ $skipsize -gt 0 ]
				then
					skipsize=$(($skipsize * 10))
			fi
			echo $skipsize
			dd if="$param1" of="$mem_temp""/""output.beingcopy" bs=10MB skip="$skipsize"
	elif [ $countsize -gt 1000000 ]
		then
			printf '1MB:%s\n' "$param1"
			if [ $skipsize -gt 0 ]
				then
					skipsize=$(($skipsize * 100))
			fi
			echo $skipsize
			dd if="$param1" of="$mem_temp""/""output.beingcopy" bs=1MB skip="$skipsize"
	elif [ $countsize -gt 100000 ]
		then
			printf '100kB:%s\n' "$param1"
			if [ $skipsize -gt 0 ]
				then
					skipsize=$(($skipsize * 1000))
			fi
			echo $skipsize
			dd if="$param1" of="$mem_temp""/""output.beingcopy" bs=100kB skip="$skipsize"
	elif [ $countsize -gt 10000 ]
		then
			printf '10kB:%s\n' "$param1"
			if [ $skipsize -gt 0 ]
				then
					skipsize=$(($skipsize * 10000))
			fi
			echo $skipsize
			dd if="$param1" of="$mem_temp""/""output.beingcopy" bs=10kB skip="$skipsize"
	elif [ $countsize -gt 1000 ]
		then
			printf '1kB:%s\n' "$param1"
			if [ $skipsize -gt 0 ]
				then
					skipsize=$(($skipsize * 100000))
			fi
			echo $skipsize
			dd if="$param1" of="$mem_temp""/""output.beingcopy" bs=1kB skip="$skipsize"
	else
			printf '1c:%s\n' "$param1"
			if [ $skipsize -gt 0 ]
				then
					skipsize=$(($skipsize * 100000000))
			fi
			echo $skipsize
			dd if="$param1" of="$mem_temp""/""output.beingcopy" bs=1c skip="$skipsize"
	fi
	
	cat "$mem_temp""/""output.beingcopy" >> "$param2""$param3"
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
            copy_file "$pathname" "$dir_dest""$param2" "$curfilename"
        fi
    done
}

sync_dir "$dir_ori" "/"


