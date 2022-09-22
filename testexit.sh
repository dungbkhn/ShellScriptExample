#!/bin/bash

#set -e

check_same_dir () {
	n=1
	echo 'hello'
	if [ $n -eq 0 ] ; then
		exit 0
	fi
	echo 'e'
	exit 1
}

check_same_dir 'abc'
echo 'emnd'
