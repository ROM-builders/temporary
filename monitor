#!/bin/bash

export CCACHE_DIR=/tmp/ccache
sleep 2m # Lunch may need 2 minutes to start the build

while : # Loop to check ccache and machine status every 1 minute
do
ccache -s
echo ''
top -b -i -n 1
sleep 1m
done
