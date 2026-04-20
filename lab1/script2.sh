#!/bin/bash

# read strings, until q was entered, print all text in one line
tmp=""
res=""
while [ "$tmp" != "q" ]; do
    res="$res$tmp"
    read tmp
done

echo "$res"
