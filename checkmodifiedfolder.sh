#!/bin/bash

shopt -s dotglob
shopt -s nullglob

glb_file_track_dir=/home/dungnt/f1
glb_file_track_file=/home/dungnt/f2

checkmodifydir(){
	# declare array
	declare -a strarr_main
	declare -a strarr_cur
	
	# set comma as delimiter
	local IFS='/'
	# local param
	local len_main line fs i j
	
	#for dirs
	fs=$(stat -c %s "$glb_file_track_dir")
	
	if [[ ! -f  "$glb_file_track_dir" ]] || [[ $fs -eq 0 ]] ; then
		exit 1
	fi

	#init
	read -a strarr_main <<< ""
	len_main=0
	
	while read -r line; 
	do 
		read -a strarr_cur <<< "$line"
		
		if [[ $len_main -gt 0 ]] ; then
			j=0
			for i in "${!strarr_cur[@]}" ; do	
				if [[ $j -lt $len_main ]] && [[ "${strarr_cur[$i]}" == "${strarr_main[$j]}" ]] ; then
					j=$(( $j + 1 ))
				else
					break;
				fi
			done
			len_main=$j
		else
			unset strarr_main
			read -a strarr_main <<< "$line"
			len_main=${#strarr_main[@]}
		fi
		
		unset strarr_cur		
	done < "$glb_file_track_dir"

	#for files
	fs=$(stat -c %s "$glb_file_track_file")

	if [[ ! -f  "$glb_file_track_file" ]] || [[ $fs -eq 0 ]] ; then
		exit 1
	fi

	while read -r line; 
	do 
		read -a strarr_cur <<< "$line"
		
		if [[ $len_main -gt 0 ]] ; then
			j=0
			for i in "${!strarr_cur[@]}" ; do	
				if [[ $j -lt $len_main ]] && [[ "${strarr_cur[$i]}" == "${strarr_main[$j]}" ]] ; then
					j=$(( $j + 1 ))
				else
					break;
				fi
			done
			len_main=$j
		else
			unset strarr_main
			read -a strarr_main <<< "$line"
			len_main=${#strarr_main[@]}
		fi
		
		unset strarr_cur		
	done < "$glb_file_track_file"
	
	outstr=""
	for i in "${!strarr_main[@]}" ; do			
		if [[ $i -lt $len_main ]]; then
			if [[ $i -eq 0 ]] ; then
				outstr=""
			else
				outstr=$(echo "$outstr""/""${strarr_main[$i]}")
			fi
		fi
	done

	echo "output:""$outstr"
}

rs=$(checkmodifydir)
code=$?

echo "$rs"
echo "$code"
