#!/bin/bash

ps aux | awk '$8 ~ /^[RSDZT]/ {print $2}'
