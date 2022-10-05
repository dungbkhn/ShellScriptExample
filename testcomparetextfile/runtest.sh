#!/bin/bash

shopt -s dotglob
shopt -s nullglob

hashlogfile="hashlog.txt"
afterhashlogfile="afterhashlog.txt"

while IFS= read -r line
do
  echo "$line"
  
  while IFS= read -r afterline
  do
	
	if [[ "$line" == "$afterline" ]] ; then
		echo "$afterline"
		break
	fi
  done < "$afterhashlogfile"
  
done < "$hashlogfile"
