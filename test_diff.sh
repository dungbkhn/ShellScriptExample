#!/bin/bash

compareresult=$( diff -qr ./dirtest1/ ./dirtest2/ )

if [[ $? != 0 ]]; then
	printf 'fail:%s\n' "$compareresult"
	if [[ $compareresult ]]; then
		#diff files
		printf 'fail-not empty:s:%s\n' "$compareresult"
	else
		#command fail
		printf 'fail-empty:%s\n' "$compareresult"
		compareresult=-1
	fi
elif [[ ! $compareresult ]]; then
	#compareresult=0
	printf 'ok empty:%s\n' "$compareresult"
else
	#compareresult=1
	printf 'not empty:%s\n' "$compareresult"
fi


echo $compareresult
