#!/bin/bash

SVNREPO="/var/svn"
TEMP="/var/tmp"
BACKUP="/home/helix/backups"
INC="0"

RED="\033[1;31m"
GREEN="\033[1;32m"

checkForSlashes() {
	for ARG in ${ARRAY[@]}; do
		if [[ $ARG == *"/"* ]]; then
			for REPO in $ARRAY; do
				ARRAY2+=($REPO)
				backupRepos $ARRAY2
			done
		else
			for REPO in $ARRAY; do
				ARRAY+=($SVNREPO/$REPO)
				backupRepo $ARRAY2
			done
		fi
	done
}

backupRepos() {
	for REPO in ${ARRAY2[@]}; do
		if [ -f $SVNREPO/$REPO/format ]; then
			svnadmin dump $SVNREPO/$REPO -r HEAD &>/dev/null | gzip > $TEMP/$REPO.svn.gzip
			echo -e "${GREEN}SUCCESS! Backup of $REPO complete."
		else
			echo -e "${RED}ERROR! The repository $REPO does not exist. No backup has been made for this argument."
		fi
	done
}

if [ $# -eq 0 ]; then
	for REPO in *; do
		ARRAY+=($REPO)
		backupRepoo $ARRAY
	done
else
	for REPO in $@; do
		ARRAY+=($REPO)
		checkForSlashes $ARRAY
	done
fi