#!/bin/bash

USERID=$(id -u)
package=$@
echo "$package"

if [ $USERID -ne 0 ]
then   
    echo "please login using root access"
    exit 1
fi


