#!/bin/bash

USERID=$(id -u)

echo "$USERID"
if [ $USERID -ne 0 ]
then   
    echo "please login using root access"
    exit 1
fi