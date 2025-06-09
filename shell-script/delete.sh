#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then   
    echo "please login using root access"
    exit 1
fi

dnf list installed $@
if [ $@ -ne 0 ]
then
    echo "please provide software names"
    exit 1
fi