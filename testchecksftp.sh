#!/bin/bash

rs=$(netstat -atn | grep ':22' | grep 'ESTABLISHED')

echo "$?"
echo $rs


#1:fail, no output
#0:ok, show output

