#!/bin/bash

shopt -s dotglob
shopt -s nullglob

hashlogfile="hashlog.txt"
num=1

#Explanation:
#NUMq will quit immediately when the line number is NUM.
#d will delete the line instead of printing it; this is inhibited on the last line because the q causes the rest of the script to be skipped when quitting.

while [ $num -lt 2 ]
do
  sed "${num}q;d" $hashlogfile
  num=`expr $num + 1`
  #num=$( $num + 1 )
done 

echo "test2"
IFS='/' read -ra ADDR <<< "/home/dungnt/Backup/Store/Projects/ShellScript/testcomparetextfile/gf\' dfg/BTL_Nguyễn Tiến Long_Đặng Trung Anh_Đào Trọng Khang_Vũ Tự Học+/sdf"
for i in "${ADDR[@]}"; do
 if [[ "$i" ]] ; then
  echo "$i"
 fi
done

echo "test3"
#Define the string to split
text="/home/dungnt/Backup/Store/Projects/ShellScript/gf\' dfg/BTL_Nguyễn Tiến Long_Đặng Trung Anh_Đào Trọng Khang_Vũ Tự Học+/sdf//.//9856456"

#Define multi-character delimiter
delimiter="//.//"
#Concatenate the delimiter with the main string
string=$text$delimiter

#Split the text based on the delimiter
myarray=()
while [[ $string ]]; do
  #${string%%"$delimiter"*}: remove longest matching suffix pattern
  myarray+=( "${string%%"$delimiter"*}" )
  string=${string#*"$delimiter"}
done

#Print the words after the split
#for value in ${myarray[@]}
#do
#  echo -n "$value "
#done
#printf "\n"

#declare -p myarray
echo ${myarray[0]}
echo ${myarray[1]}


echo "test4"

n=10

if [[ $n -eq 10 ]] ; then
	echo "=10"
fi

echo "test4"

n=$(( $n+1 ))

echo $n

if [[ $n -eq 11 ]] ; then
	echo "=11"
fi

echo "test5"

m=""

if [[ -z "$m" ]] ; then
	echo "empty"
else
	echo "not empty"
fi

if [[ "$m" ]] ; then
	echo "not empty"
else
	echo "empty"
fi

echo "test6"

# declare array
declare -a name
declare -a subname
declare -a subnameisfile
declare -a level
declare -a hassamedir

count=0
while IFS=/ read -r beforeslash afterslash_1 afterslash_2 afterslash_3 afterslash_4
do
	name[$count]="$afterslash_1"
	#echo "${name[$count]}"" ""$count"
	subname[$count]="$afterslash_2"
	subnameisfile[$count]="$afterslash_3"
	level[$count]="$afterslash_4"
	hassamedir[$count]=0
	count=$(($count + 1))
done < /home/dungnt/filesedoc.txt

echo "${name[0]}"

echo "test7"

contain_special_character_Win_forbidden(){
	local prm=$1

	if [[ "$prm" == *\** ]] || [[ "$prm" == *\"* ]] || [[ "$prm" == *\?* ]] || [[ "$prm" == *\<* ]] || [[ "$prm" == *\>* ]] || [[ "$prm" == *\:* ]] || [[ "$prm" == *\\* ]] || [[ "$prm" == *\|* ]] ; then
			return 0	
	else
			return 1
	fi
}

dir1=/home/dungnt/Test
for pathname in "$dir1"/* ;do
		pathname=$(basename "$pathname")
		#echo "$pathname"
		#if [[ "$pathname" == *\** ]] || [[ "$pathname" == *\"* ]] || [[ "$pathname" == *\?* ]] || [[ "$pathname" == *\<* ]] || [[ "$pathname" == *\>* ]] || [[ "$pathname" == *\:* ]] || [[ "$pathname" == *\\* ]] || [[ "$pathname" == *\|* ]] ; then
		#	echo "$pathname"		
		#fi
		contain_special_character_Win_forbidden "$pathname"
		code=$?
		if [[ $code -eq 0 ]] ; then
			echo "$pathname" 
		fi		
done

echo "test8"
start_time=$SECONDS
sleep 5
elapsed=$(( $SECONDS - $start_time ))
echo $elapsed

start_time=$SECONDS
sleep 5
elapsed=$(( SECONDS - start_time ))
echo $elapsed



