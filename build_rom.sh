#!/bin/bash

set -exv

# build rom
source build/envsetup.sh
lunch lineage_daisy-userdebug
mka clean
mka bacon

# Trigger zone
# Tue May 11 21:30:09 EEST 2021


