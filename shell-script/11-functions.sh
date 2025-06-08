#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "ERROR: you must have root access to execute this script"
    exit 1; #other than 0
fi

VALIDATE(){
    if [ $1 -ne 0 ]
    then   
        echo "$2...FAILURE"
        exit 1
    else
        echo "$2...SUCCESS"
    fi
}
dnf list installed mysql

if [ $? -ne 0 ]
then #not installed
    dnf install mysql -y
    VALIDATE $? "Installing MySQL"
else
    echo "MySQL is already ... INSTALLED"
fi

dnf list installed git

if [ $? -ne 0 ]
then #not installed
    dnf install git -y
    VALIDATE $? "Installing GIT"
else   
    echo "Git is already .. INSTALLED"
fi

