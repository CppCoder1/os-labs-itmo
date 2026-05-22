#!/bin/bash

ps -eo pid --sort=-etimes | sed -n '2p'
