#!/bin/bash

REPOS="/var/svn"
GREEN="\033[1;32M"
RED="\033[1;31M"

if [ $# -eq 0 ]; then
	rm -rf $REPOS/*
	echo -e "${GREEN}Success! $REPOS is empty."
else
	for ARG in $@; do
		if [ -d $REPOS/$ARG ]; then
			rm -rf $REPOS/$ARG
			echo -e "${GREEN}Success! $ARG has been removed from $REPOS."
		else
			echo -e "${RED}$REPOS/$ARG does not exist."
		fi
	done
fi