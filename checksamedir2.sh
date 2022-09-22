#!/bin/bash

shopt -s dotglob
shopt -s nullglob
 
dir_src=/home/dungnt/ShellScript/dirtest1
dir_dest=/home/dungnt/ShellScript/dirtest2
mem_temp=/home/dungnt/ShellScript/temp

copyfilesize="1KB"
truncsize=1000
countsize=0
skipsize=0
founddirname=""

check_same_dir () {
	local param1=$1
	local param2=$2
	local pathname1
	local pathname2
	local curfilename1
	local curfilename2
	local countsameelement
	
	countsameelement=0
	
	for pathname1 in "$param1"/*; do
		curfilename1=$(basename "$pathname1")
		for pathname2 in "$param2"/*; do
			if [ -d "$pathname1" ]; then
				if [ -d "$pathname2" ]; then
					curfilename2=$(basename "$pathname2")
					if [ "$curfilename1" == "$curfilename2" ] ; then
						countsameelement=$(($countsameelement + 1))
					fi
				fi
			else
				if [ ! -d "$pathname2" ]; then
					curfilename2=$(basename "$pathname2")
					if [ "$curfilename1" == "$curfilename2" ] ; then
						countsameelement=$(($countsameelement + 1))
					fi
				fi
			fi
		done
	done
	

	
	return "$countsameelement"
}

find_same_dir () {
	local param1=$1
	local param2=$2
	local param3=$3
	local curdirname
	local pathname
	local countsameelement
	local findresult
	local max
	local cmd
	local kq
	
	echo "$param2"
	echo "$param3"
	
	findresult=$(find "$param2" -type d -name "$param3")
	cmd=$?
	
	#neu tim thay thu muc o dia chi dich trung ten
	if [ "$cmd" -eq 0 ] && [ "$findresult" ] ; then
		kq=1
	else
		#neu ko tim thay
		max=1
		for pathname in "$param2"/*; do
			if [ -d "$pathname" ]; then
				#mapping nguoc lai
				curdirname=$(basename "$pathname")
				findresult=$(find "$param1" -type d -name "$curdirname")
				cmd=$?
				
				if [ ! "$findresult" ] ; then
					#neu ko tim thay khi mapping thi so sanh noi dung 2 thu muc
					check_same_dir "$param1""/""$param3" "$pathname"
					cmd=$?
					if [ "$cmd" -gt "$max" ]; then
						max=$cmd
						founddirname=$pathname
					fi
				fi
			fi
		done
		
		printf 'max:%s\n' "$max"
		
		if [ "$max" -gt 1 ]; then
			kq=2
		else
			kq=0
		fi
		
	fi
	
	#0:ko tim thay
	#1:tim thay trung ten
	#2:tim thay khac ten nhung noi dung chua nhieu ptu giong nhau
	
	return "$kq"
}

directory="b"
find_same_dir "$dir_src" "$dir_dest" "$directory"

#check_same_dir "$dir_src" "$dir_dest"
echo $?
echo "$founddirname"
