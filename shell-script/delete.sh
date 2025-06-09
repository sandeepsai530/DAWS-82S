#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then   
    echo "please login using root access"
    exit 1
fi

echo "please install mysql packages if not installed already"

dnf list installed mysql
if [ $? -ne 0 ]
then
    dnf install mysql -y
    echo "package MYSQL installed"
fi