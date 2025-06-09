#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "this script can be executed with root access only"
    exit 1;
fi

dnf list installed mysql

if [ $? -ne 0 ]
then
    echo "MySQL is installing"
    dnf install mysql -y
else
    echo "MySQL is already installed"
fi

dnf list installed git

if [ $? -ne 0 ]
then
    echo "GIT is installing"
    dnf install git -y
else
    echo "GIT is already installed"
fi
