#!/bin/bash

GREEN="\033[1;32m]"
FILE=$1

sudo gpg -c $FILE
echo -e "${GREEN}Your file has been successfully encrypted.  New filepath is $FILE.gpg"

sudo rm -rf $FILE