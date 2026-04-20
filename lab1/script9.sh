#!/bin/bash

find /var/log -type f -name "*.log" | xargs wc -l
