#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"

VALIDATE(){
    if [ $1 -ne 0 ]
    then   
        echo -e "$2...$R FAILURE"
        exit 1
    else
        echo -e "$2...$G SUCCESS"
    fi
}

CHECK_ROOT(){
    if [ $USERID -ne 0 ]
    then
        echo "ERROR: you must have root access to execute this script"
        exit 1; #other than 0
    fi
}

for package in $@
do
    dnf list installed $package
    if [ $? -ne 0 ]
    then #not installed
        dnf install mysql -y
        VALIDATE $? "Installing MySQL"
    else
        echo -e "MySQL is already ... $Y INSTALLED"
    fi