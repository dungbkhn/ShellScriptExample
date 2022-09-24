#!/bin/bash
shopt -s dotglob
shopt -s nullglob

glb_mainmem_local="/home/dungnt/Backup/Store/MySyncDir"
hashlogfile="afterhashlog.txt"
glb_DirHash=""

get_dir_hash(){
	local dir_ori="$1"
	local relative_path="$2"
	local pathname
	local dname
			
	for pathname in "$dir_ori"/* ; do
		if [ -d "$pathname" ] ; then 
			dname=$(basename "$pathname")
			echo "$relative_path""/""$dname" >> "$hashlogfile"
			glb_DirHash=$(stat "$pathname" -c '%Y')
			echo "$glb_DirHash" >> "$hashlogfile"			
			get_dir_hash "$pathname" "$relative_path""/""$dname"
		fi
	done
}

glb_DirHash=$(stat "$glb_mainmem_local" -c '%Y')
echo "/" >> "$hashlogfile"
echo "$glb_DirHash" >> "$hashlogfile"
get_dir_hash "$glb_mainmem_local" ""
