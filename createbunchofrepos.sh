#!/bin/bash

INC="0"
SVN="/var/svn"
ARRAY=()

GREEN="\033[1;32m"
RED="\033[1;31m"

if [[ -n ${input}//[0-9]/ ]]; then
	echo "testing"
fi

if [ $# -eq 0 ]; then 
	REPO="$SVN/test"
	ARRAY+=($REPO)
else
	for ARG in $@; do
		INC=$((INC+1))
		REPO=$SVN/Test$INC
		ARRAY+=($REPO)
	
	done
fi

for ITEM in $ARRAY; do
	echo $ITEM
	mkdir $ITEM
	svnadmin create $ITEM
	echo -e "${GREEN}SUCCESS! woo"
done

