#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then   
    echo "please login using root access"
    exit 1
fi

echo "please install $@ packages if not installed already"

dnf list installed $@
if [ $? -ne 0 ]
then
    dnf install $@ -y
    if [ $? -eq 0]
    then
        echo "package $@ installed"
    else
        echo "package name is not correct"
    fi
fi