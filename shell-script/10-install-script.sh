#!/bin/bash

USERID=$(id -u)

if [ USERID -ne 0 ]
then
    echo "ERROR: you must have root access to execute the script"
    exit 1; #other than 0
fi
dnf list installed mysql