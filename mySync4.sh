#!/bin/bash

#danh cho copy file

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
	filesize=$(wc -c "$param1" | awk '{print $1}')
	
	if [ $? == 0 ] && [ $filesize ] && [ "$filesize" -gt 0 ] ; then
	
		filesize=$(($filesize / $truncsize))
		printf 'filesize:%s\n' "$filesize"
		cursize=0
		
		while [ $cursize -lt $filesize ]
		do
			rm "$mem_temp"/*
			
			#printf 'dd:%s to %s\n' "$param1" "$mem_temp""/""$param3"
			dd if="$param1" of="$mem_temp""/""output.beingcopy" bs="$copyfilesize" count=1 skip="$cursize"
			if [ $cursize -eq 0 ]
				then
					cp "$mem_temp""/""output.beingcopy" "$param2""$param3"
				else
					cat "$mem_temp""/""output.beingcopy" >> "$param2""$param3"
			fi

			cursize=$(($cursize + 1))
			echo $cursize

		done
		
		#lam lan cuoi
		mycommand="rm ""$mem_temp""/""output.beingcopy"
		echo $mycommand
		eval $mycommand
		
		skipsize=$cursize
		
		dd if="$param1" of="$mem_temp""/""output.beingcopy" bs="$copyfilesize" skip="$skipsize"
		cat "$mem_temp""/""output.beingcopy" >> "$param2""$param3"
	fi
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


