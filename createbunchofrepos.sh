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

#UNTIL loop

until [ $INC = $INPUT ]; do
	INC=$((INC+1))
	mkdir $SVN/Test$INC
	svnadmin create $SVN/Test$INC
done