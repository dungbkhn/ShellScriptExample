#!/bin/bash

shopt -s dotglob
shopt -s nullglob
 
i=0
start_time=$SECONDS
while true; do
	
	rs=$(curl 127.0.0.1:7878 2>&1)
	echo "$rs"
	i=$(( $i+1 ))
	if [[ $i -eq 200 ]] ; then break; fi

done
elapsed=$(( SECONDS - start_time ))
echo $elapsed

