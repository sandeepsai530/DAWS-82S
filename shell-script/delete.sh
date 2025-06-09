#!/bin/bash

USERID=$(id -u)
package=$1

if [ $USERID -ne 0 ]
then   
    echo "please login using root access"
    exit 1
fi
echo "$package"
if [ $? -ne 0 ]
then
    echo "please enter software names"
    exit 1
fi
