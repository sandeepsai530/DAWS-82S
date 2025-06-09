#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then   
    echo "please login using root access"
    exit 1
fi

echo "please install $@ packages if not installed already"

dnf list installed $@