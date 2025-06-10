#!/bin/bash

R="\e[31m" 
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} #if user is not providing the no. of days, it will take default as 14

LOGS_FOLDER="/root/DAWS-82S/shellscript-logs"
LOG_FILE=$(echo $0 | cut -d "." -f1 )
TIMESTAMP=$(date +%Y-%M-%D-%H-%M-%S)
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE_NAME-$TIMESTAMP.log"

USAGE(){
    echo -e "$R USAGE: $N filename <SOURCE_DIR> <DEST_DIR> <DAYS(optional)>"
    exit 1
}

mkdir -p /root/DAWS-82S/shellscript-logs

if [ $# -lt 2 ]
then
    USAGE
fi

if [ ! -d "$SOURCE_DIR" ]
then
    echo "$SOURCE_DIR does not exist..please check"
    exit 1
fi

if [ ! -d "$DEST_DIR" ]
then
    echo "$DEST_DIR does not exist..please check"
    exit 1
fi

echo "script started executing from: $TIMESTAMP"

FILES=$(find $SOURCE_DIR -name "*.log" -mtime +$DAYS)

if [ -n "$FILES" ] #true files exists
then
    echo "Files are: $FILES"
    ZIP_FILE="$DEST_DIR/app-logs-$TIMESTAMP.zip"
    find $SOURCE_DIR -name "*.log" -mtime +$DAYS | zip -@ "$ZIP_FILE"
    if [ -f $ZIP_FILE ]
    then
        echo "successfully created zip file for files older than $DAYS"
        while read -r filepath # here filepath is the variable name, you can give any name
        do
            echo "Deleting file: $filepath" 
            rm -rf $filepath
            echo "deleted file: $filepath"
        done <<< $FILES
    else
        echo "$R Error: $N failed to create zip file"
        exit 1
    fi
else
    echo "No files found older than $DAYS"
fi