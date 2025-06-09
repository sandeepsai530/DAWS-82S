#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "this script can be executed with root access only"
    exit 1;
fi

dnf list installed