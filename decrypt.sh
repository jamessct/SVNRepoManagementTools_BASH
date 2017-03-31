#!/bin/bash

GREEN="\033[1;32m]"
FILE=$1

sudo gpg $FILE
sudo rm -rf $FILE

echo -e "${GREEN}$FILE has been decrypted."