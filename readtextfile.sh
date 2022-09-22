#!/bin/bash

while IFS= read -r line
do
  value="$line"
done < "read_file.txt"

echo $value
echo $(($value + 1))
curtime=$(($(date +%s%N)/1000000))

echo $curtime

delaytime=$(( ( $curtime - $value ) / 60000 ))
echo $delaytime
if [ $delaytime -gt 5 ] ; then
	echo '>5m'
else
	echo '<=5m'
fi

