#!/bin/bash

#Syntax: Read file line by line on a Bash Unix & Linux shell
#The syntax is as follows for bash, ksh, zsh, and all other shells to read a file line by line:

#while read -r line; do COMMAND; done < input.file

#The -r option passed to read command prevents backslash escapes from being interpreted.
#Add IFS= option before read command to prevent leading/trailing whitespace from being trimmed.
#while IFS= read -r line; do COMMAND_on $line; done < input.file

#input="./.bash_history"
#while IFS= read -r line
#do
#  echo "$line"
#done < "$input"

#The -q option tells grep to be quiet, to omit the output.

STR="GNU/Linux is /@#$%^& ' an operating system"
SUB="/@#$%^& '"

if grep -q "$SUB" <<< "$STR"; then
  echo "It's there"
fi
