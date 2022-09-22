#!/bin/bash

shopt -s dotglob
shopt -s nullglob
 
dir_ori=/home/dungnt/ShellScript/dirtest1
dir_dest=/home/dungnt/ShellScript/dirtest2


getdirnameFromFullPath () {
	dircurname=${1%%+(/)}    # trim however many trailing slashes exist
	dircurname=${dircurname##*/}       # remove everything before the last / that still remains
}

sync_dir () {
    for pathname in "$1"/*; do
        if [ -d "$pathname" ]; then
			printf 'dir:%s\n' "$pathname"
			getdirnameFromFullPath "$pathname"
			printf 'dirname:%s\n' "$dircurname"
			echo "$dir_dest/$dircurname"
			mkdir "$dir_dest/$dircurname"
            sync_dir "$pathname"
        else
            printf '%s\n' "$pathname"
            cp "$pathname" "$dir_dest/$dircurname"
        fi
    done
}

sync_dir "$dir_ori"


