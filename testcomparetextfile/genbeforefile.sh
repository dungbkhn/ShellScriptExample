#!/bin/bash
shopt -s dotglob
shopt -s nullglob

f(){
	if [ "$1" -lt 10 ] ; then
		return 1
	else
		return 2
	fi
}

f 30

echo "$?"
