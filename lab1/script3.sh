#!/bin/bash

# open program chosen by user
while :
do
    clear
    echo -e "Choose option (Enter the number of option):\n1) nano\n2) vi\n3) links\n4) quite"
    read key
    case "$key" in
        "1")
            nano
            ;;
        "2")
            vi
            ;;
        "3")
            links
            ;;
        "4")
            break
            ;;
    esac
done

