#!/bin/bash

REPOS="/var/svn"
GREEN="\033[1;32m"
RED="\033[1;31m"
YELLOW="\033[1;33m]"

if [ $# -eq 0 ]; then
	for REPO in $REPOS/*; do
		rm -rf $REPOS/*
		echo -e "${YELLOW}$REPO has been removed."
	done
	echo -e "${GREEN}SUCCESS! message (:"
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