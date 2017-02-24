#!/bin/bash

INC="0"
SVN="/var/svn"
INPUT=$@
ARRAY=()

GREEN="\033[1;32m"
RED="\033[1;31m"

sortArguments() {
	for ARG in $INPUT; do
		if [[ -n ${INPUT//[0-9]/} ]]; then
			if [ -d $SVN/$INPUT ]; then
				echo -e "${RED}ERROR! A directory already exists at $SVN/$INPUT. No action will be taken for this request."
			else
				REPO=$SVN/$INPUT
				ARRAY+=($REPO)
			fi
		else
			incrementTests $ARG
		fi
	done
	createRepo $ARRAY[@]
}
	
incrementTests() {
	until [ $INC = $ARG ]; do	
		INC=$((INC+1))
		if [ -d $SVN/test$INC ]; then
			echo -e "${RED}ERROR! A directory already exists at $SVN/test$INC. No action will be taken for this request."
		else
				ARRAY+=($SVN/test$INC)
		fi
	done
	createRepo $ARRAY[@]
}

createRepo() {
	for ITEM in ${ARRAY[@]}; do
		mkdir $ITEM 2>/Dev/Null
		svnadmin create $ITEM
		echo -e "${GREEN}SUCCESS! Your new repository has been created at $ITEM."
	done	
}

if [ $# -eq 0 ]; then
	REPO="$SVN/test"
	ARRAY+=($REPO)
	createRepo $ARRAY[@]
else
	sortArguments
fi