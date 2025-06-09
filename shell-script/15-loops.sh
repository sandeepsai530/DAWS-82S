#!/bin/bash

# if [ $1 -ne 0 ]
# then    
#     echo "please provide software names that to be installed"
#     exit 1
# fi

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"

LOGS_FOLDER="/var/log/shellscript-logs"
LOG_FILE=$(echo $0 | cut -d "." -f1 )
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP.log"

echo "script started executing at: $TIMESTAMP" &>>$LOG_FILE_NAME

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
    dnf list installed $package &>>$LOG_FILE_NAME
    if [ $? -ne 0 ]
    then #not installed
        dnf install mysql -y &>>$LOG_FILE_NAME
        VALIDATE $? "Installing $package"
    else
        echo -e "$package is already ... $Y INSTALLED"
    fi
done