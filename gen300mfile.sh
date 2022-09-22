#!/bin/bash
 
shopt -s dotglob
shopt -s nullglob

pos=/home/dungnt/ShellScript
file_ori=/home/dungnt/ShellScript/mySync_final.sh

count=0
rm "$pos"/file_nhieu_mb.txt
touch "$pos"/file_nhieu_mb.txt

while [ $count -le 400 ]
do
  cat "$file_ori" >> "$pos"/file_nhieu_mb.txt
  count=$(( $count + 1 ))
done

