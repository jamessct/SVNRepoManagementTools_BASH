#!/bin/bash

INC="0"
SVN="/var/svn"
INPUT=$@
ARRAY=()

GREEN="\033[1;32m"
RED="\033[1;31m"

#alternative refactored version
sortArguments() {
	for ARG in $@; do
		if [[ -n ${INPUT//[0-9]/} ]]; then
			REPO=$SVN/$INPUT
			ARRAY+=($REPO)
			createRepo $ARRAY
		else
			incrementTests $ARG
		fi
	done
}
	
incrementTests() {
	until [ $INC = $ARG ]; do	
		INC=$((INC+1))
		if [ -d /$SVN/test$INC ]; then
			echo -e "${RED}ERROR! A directory already exists at $ITEM. No action will be taken for this request."
		else
				ARRAY+=($SVN/test$INC)
		fi
	done
}

createRepo() {
	for ITEM in $ARRAY; do
		mkdir $ITEM
		svnadmin create $ITEM
		echo -e "${GREEN}SUCCESS! Your new repository has been created at $ITEM."
	done	
}

if [ $# -eq 0 ]; then
	REPO="$SVN/test"
	ARRAY+=($REPO)
	createRepo $ARRAY
else
	sortArguments $@
fi