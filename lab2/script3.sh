#!/bin/bash

ps -eo pid --sort=-start_time | sed -n '2p'
