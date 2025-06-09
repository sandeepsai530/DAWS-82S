#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then   
    echo "please login using root access"
    exit 1
fi

for package in $@
do
    dnf list installed $package
    if [ $? -ne 0 ]
    then
        dnf install $package -y
    else
        echo "package already installed"
    fi
done