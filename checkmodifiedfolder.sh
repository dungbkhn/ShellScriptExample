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
	local len_main line fs1 fs2 i j passdir passfile
	local folder=$1
	local curdir=$(pwd)
	
	cd "$folder"
	find . -type d -mmin -3 > "$glb_file_track_dir"
	find . -type f -mmin -3 > "$glb_file_track_file"
	cd "$curdir"
	
	#for dirs
	fs1=$(stat -c %s "$glb_file_track_dir")
	
	#init
	read -a strarr_main <<< ""
	len_main=0
	passdir=0
	
	if [[ ! -f  "$glb_file_track_dir" ]] || [[ $fs1 -eq 0 ]] ; then
		passdir=1
	fi
	
	if [[ $passdir -eq 0 ]] ; then
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
	fi
	
	#for files
	fs2=$(stat -c %s "$glb_file_track_file")

	if [[ ! -f  "$glb_file_track_file" ]] || [[ $fs2 -eq 0 ]] ; then
		passfile=1
	fi

	if [[ $passfile -eq 0 ]] ; then
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
	fi
	
	if [[ $passdir -eq 1 ]] && [[ $passfile -eq 1 ]] ; then
		exit 1
	fi
	
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
	
	exit 0
}

rs=$(checkmodifydir "/home/dungnt/Backup/Store/MySyncDir")
code=$?

if [[ "$code" == "0" ]] ; then
	echo "co output do, neu output la xau rong thi co nghia la thu muc root co thay doi"
	echo "$rs"
else
	echo "co loi voi exit =1, co the ca hai file deu ko ton tai hoac ko co du lieu"
fi
