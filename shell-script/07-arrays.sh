#!/bin/bash

MOVIES=("Apple","Beetroot","Carrot")

echo "First movie name: ${MOVIES[$0]}"
echo "First movie name: ${MOVIES[$1]}"
echo "First movie name: ${MOVIES[$2]}"

echo "To print all movies use @: ${MOVIES[$@]}"