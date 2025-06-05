#!/bin/bash

MOVIES=("Apple" "Beetroot" "Carrot")

echo "First movie name: ${MOVIES[$0]}"
echo "Second movie name: ${MOVIES[$1]}"
echo "Third movie name: ${MOVIES[$2]}"

echo "To print all movies use @: ${MOVIES[$@]}"