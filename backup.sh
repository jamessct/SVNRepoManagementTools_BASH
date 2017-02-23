#!/bin/bash

SVNREPO="/var/svn"
TEMP="/var/tmp"
BACKUP="/home/helix/backups"

RED="\033[1;31m"
GREEN="\033[1;32m"

cd $SVNREPO

#Determining whether the argument is a file or not
for ARG in $@; do
	echo "$ARG"
	if [ $ARG == "/" ]; then
		for REPO in $ARG; do
			ARRAY+=($REPO)
		done
	else
		for REPO in $@; do
			ARRAY+=($SVNREPO/$REPO)
		done
	fi
done

if [ $# -eq 0 ]; then
	for REPO in *; do
		ARRAY+=($REPO)
	done
else
	for REPO in $@; do
		ARRAY+=($REPO)
	done
fi
	
for REPO in ${ARRAY[@]}; do
	if [ -f $SVNREPO/$REPO/format ]; then
		vnadmin dump $SVNREPO/$REPO -r HEAD &>/dev/null | gzip > $TEMP/$REPO.svn.gzip
		cp $TEMP/$REPO.svn.gzip $BACKUP/$REPO.svn.gzip
		rm $TEMP/$REPO.svn.gzip
		echo -e "${GREEN}Backup of $REPO complete."
	else
		echo -e "${RED}ERROR! The repository $REPO does not exist. No backup has been made for this argument."
	fi
done