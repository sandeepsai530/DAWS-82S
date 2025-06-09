#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then   
    echo "please login using root access"
    exit 1
fi

echo "please install $@ packages if not installed already"


for package in $@
do
    dnf list installed $package
    if [ $? -ne 0 ]
    then
        dnf install $@ -y
    else
        echo "please enter valid package name"
    fi
done