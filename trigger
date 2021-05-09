#!/bin/bash

time=$(date)
echo "#$time" >> trigger
git add . && git commit -m trigger

# trigger zone
#Sun  9 May 14:34:41 CEST 2021
