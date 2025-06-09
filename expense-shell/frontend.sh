#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="/var/log/expense-logs"
LOG_FILE=$(echo $0 | cut -d "." -f1 )
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP.log"

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

echo "script started executing at: $TIMESTAMP" &>>$LOG_FILE_NAME

CHECK_ROOT

mkdir -p $LOGS_FOLDER

dnf install nginx -y &>>$LOG_FILE_NAME
VALIDATE $? "Installing nginx server"

systemctl enable nginx &>>$LOG_FILE_NAME
VALIDATE $? "Enabling nginx"

systemctl start nginx &>>$LOG_FILE_NAME
VALIDATE $? "starting nginx"

rm -rf /usr/share/nginx/html/* &>>$LOG_FILE_NAME
VALIDATE $? "removing old content"

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip
VALIDATE $? "Downloading frontend code"

cd /usr/share/nginx/html &>>$LOG_FILE_NAME
VALIDATE $? "extracting the code"

unzip /tmp/frontend.zip &>>$LOG_FILE_NAME
VALIDATE $? "unzip the frontend code"


cp /home/ec2-user/DAWS-82S/expense-shell/expense.conf /etc/nginx/default.d/expense.conf
VALIDATE $? "Copied expense config"

systemctl restart nginx &>>$LOG_FILE_NAME
VALIDATE $? "restarting nginx"