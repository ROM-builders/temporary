#!/bin/bash

set -exv

# build rom
. build/envsetup.sh
lunch aosp_X00T-userdebug
mka bacon -j$(nproc --all)
