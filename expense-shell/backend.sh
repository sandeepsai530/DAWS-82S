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

dnf module disable nodejs -y &>>$LOG_FILE_NAME
VALIDATE $? "disabling existing nodejs"

dnf module enable nodejs:20 -y &>>$LOG_FILE_NAME
VALIDATE $? "enabling nodejs:20"

dnf install nodejs -y &>>$LOG_FILE_NAME
VALIDATE $? "installing nodejs"

useradd -p expense &>>$LOG_FILE_NAME
VALIDATE $? "adding expense user"

mkdir /app
VALIDATE $? "creating app directory"

curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip
VALIDATE $? "downloading application code"

cd /app

unzip /tmp/backend.zip
VALIDATE $? "unzip the backend file"

cd /app

npm install
VALIDATE $? "installing dependencies"

cp /home/ec2-user/DAWS-82S/expense-shell/backend.service /etc/systemd/system/backend.service

#prepare MYSQL schema
dnf install mysql -y &>>$LOG_FILE_NAME
VALIDATE $? "installing MYSQL client"

mysql -h mysql.saisandeep-devops.xyz -uroot -pExpenseApp@1 < /app/schema/backend.sql
VALIDATE $? "setting up the transactions schema and tables"

systemctl daemon-reload &>>$LOG_FILE_NAME
VALIDATE $? "relaoding the daemon"

systemctl enable backend &>>$LOG_FILE_NAME
VALIDATE $? "enabling the backend"

systemctl start backend &>>$LOG_FILE_NAME
VALIDATE $? "starting the backend server"


