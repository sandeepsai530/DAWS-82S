#!/bin/bash

echo "All variables passed: $@"
echo "number of varibales passed: $#"
echo "script name: $0"
echo "present working directory: $PWD"
echo "Home directory of current user: $HOME"
echo "which user is running this script: $USER" 
echo "process id of current script: $$"
echo "previous command exit code status:$?"
sleep 60 &
echo "process id of last command running in background: $!"