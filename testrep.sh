#!/bin/bash	


INC="0"
SVN="/var/svn"
INPUT=$@
GREEN="\033[1;32m"
RED="\033[1;31m"

sortArguments() {
	if [[ -n ${INPUT//[0-9]/} ]]; then
		for ARG in $INPUT; do
			REPO=$SVN/$INPUT
			ARRAY+=($REPO)
		done	
		createRepo $ARRAY	
	else	
		for ARG in $INPUT; do REPO=$SVN/$ARG
			incrementTests $ARG
		done	
	fi
}
	
incrementTests() {
	until [ $INC = $ARG ]; do	
		INC=$((INC+1))
		ARRAY+=($SVN/test$INC)
	done
	createRepo $ARRAY[@]
}

createRepo() {
	for ITEM in ${ARRAY[@]}; do
		if [ -d $ITEM ]; then
			echo -e "${RED}ERROR! A directory already exists at $ITEM. No action will be taken for this request."
		else
			mkdir $ITEM 2>/dev/null
			svnadmin create $ITEM
			echo -e "${GREEN}SUCCESS! Your new repository has been created at $ITEM."
		fi
	done	
}

if [ $# -eq 0 ]; then
	REPO="$SVN/test"
	ARRAY+=($REPO)
	createRepo $ARRAY
else
	sortArguments
fi