#!/bin/bash

echo "please enter username:"

#read USERNAME #username will be displayed on console while writing
read -s USERNAME #by writing -s , username will not be displayed while writing on console
echo "you entered username as : $USERNAME"

echo "please enter password:"
read -s PASSWORD #password will not be displayed on console