#!/bin/bash

time=$(date)
echo "#$time" >> trigger
git add . && git commit -m trigger

# trigger zone
#Sun  9 May 14:34:41 CEST 2021
#Sun  9 May 15:50:34 CEST 2021
#Sun  9 May 19:10:03 CEST 2021
#Mon May 10 09:06:36 CEST 2021
