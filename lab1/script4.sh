#!/bin/bash

if [[ $PWD == $HOME ]] then
    echo $HOME
    exit 0
else
    echo "U R FUCKING STUPID!"
    exit 1
fi
