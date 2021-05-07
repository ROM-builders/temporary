#!/bin/bash

set -exv

# build rom
source build/envsetup.sh
lunch p404_whyred-userdebug
m bacon
