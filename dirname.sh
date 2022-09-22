#!/bin/bash

#dirname='/home/dungnt/ShellScript/dirtest1/Btc Quantum'
#dirname=$1
#echo $dirname
#shopt -s extglob           # enable +(...) glob syntax
#result=${dirname%%+(/)}    # trim however many trailing slashes exist
#result=${result##*/}       # remove everything before the last / that still remains
#printf '%s\n' "$result"

shopt -s extglob

dirname='//////home/dungnt/ShellScript/dirtest1/Btc Q(*^*""&% (*Yuantum'

getdirnameFromFullPath () {
	dircurname=${1%%+(/)}    # trim however many trailing slashes exist
	dircurname=${dircurname##*/}       # remove everything before the last / that still remains
}

getdirnameFromFullPath "$dirname"
printf '%s\n' "$dircurname"
