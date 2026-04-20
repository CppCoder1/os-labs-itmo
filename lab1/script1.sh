#!/bin/bash

# print maximum of 3 arguments
for var in "$@"; do
    echo "$var"
done | sort
