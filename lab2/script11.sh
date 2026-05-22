#!/bin/bash
res=$(grep -si 'VmRSS:' /proc/[0-9]*/status | awk -F'/' '{print $3, $0}' | sort -nk 3 | tail -n 1 | awk '{print $1}')
ps -p $res -o comm=


