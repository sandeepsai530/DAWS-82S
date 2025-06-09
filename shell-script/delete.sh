#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then   
    echo "please login using root access"
    exit 1
fi

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 ... $R FAILURE $N"
        exit 1
    else
        echo -e "$2 ... $G SUCCESS $N"
    fi
}

for package in $@
do
    dnf list installed $package
    if [ $? -ne 0 ]
    then
        dnf install $package -y
        VALIDATE $? "installing $package"
    else
        echo "package already installed"
    fi
done