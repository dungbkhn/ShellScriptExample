#!/bin/bash

shopt -s dotglob
shopt -s nullglob

hashlogfile=./hashlog.txt
testhashlogfile=./testhashlog.txt

rs=$(diff "$hashlogfile" "$testhashlogfile")

if [ "$rs" ] ; then
	#echo 'sleep 2 phut'"----afterhash:""$glb_afDirHash"
	#echo '###ok###' >> "$mainlogfile"
	#sleep 120
	echo "$rs""--n1"
	exit 0
else
	#break
	echo "$rs""--n2"
	exit 1
fi
