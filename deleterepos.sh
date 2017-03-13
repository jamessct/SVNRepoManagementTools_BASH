#!/bin/bash

INPUT=@
REPOS="/var/svn"
GREEN="\033[1;32m"
RED="\033[1;31m"
YELLOW="\033[1;33m]"

if [ $# -eq 0 ]; then
	for REPO in $REPOS/*; do
		rm -rf $REPOS/*
		echo -e "${YELLOW}$REPO has been removed."
	done
	echo -e "${GREEN}SUCCESS! $REPOS is empty."
else
	for ARG in $INPUT; do
		if [ -d $REPOS/$ARG ]; then
			rm -rf $REPOS/$ARG
			echo -e "${GREEN}SUCCESS! $REPOS/$ARG has been removed."
		else
			echo -e "${RED}$REPOS/$ARG does not exist."
		fi
	done
fi