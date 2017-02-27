#!/bin/bash

INPUT=$@
SVNREPO="/var/svn"
TEMP="/var/tmp"
BACKUP="/home/helix/backups"
INC="0"

RED="\033[1;31m"
GREEN="\033[1;32m"

checkForArguments() {
	cd $SVNREPO

	if [ $# -eq 0 ]; then
		for REPO in *; do
			ARRAY+=($SVNREPO/$REPO)
		done
		backupRepos $ARRAY
	else
		for REPO in $INPUT; do
			ARRAY1+=($REPO)
		done
		checkForSlashes $ARRAY1
	fi
}

checkForSlashes() {
	for ARG in ${ARRAY1[@]}; do
		if [[ $ARG == *"/"* ]]; then
			for REPO in $ARRAY1; do
				ARRAY+=($REPO)
			done
		else
			for REPO in $ARRAY1; do
				ARRAY+=($SVNREPO/$REPO)
			done
		fi
		backupRepo $ARRAY
	done
}

backupRepos() {
	for REPO in ${ARRAY[@]}; do
		if [ -f $SVNREPO/$REPO/format ]; then
			svnadmin dump $SVNREPO/$REPO -r HEAD &>/dev/null | gzip > $TEMP$REPO.svn.gzip
			cp $TEMP$REPO.svn.gzip $BACKUP$REPO.svn.gzip
			rm $REMP$REPO.svn.gzip
			echo -e "${GREEN}SUCCESS! Backup of $REPO complete."
		else
			echo -e "${RED}ERROR! The repository $REPO does not exist. No backup has been made for this argument."
		fi
	done
}

checkForArguments()