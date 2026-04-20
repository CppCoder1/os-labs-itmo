#!/bin/bash

man bash | grep -Eo '\b[a-zA-Z]{4,}\b' | sort | uniq -c | sort -rn | head -n 3
