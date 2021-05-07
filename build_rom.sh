#!/bin/bash

set -exv

# build rom
. build/envsetup.sh
lunch aosp_X00TD-userdebug
mka bacon -j$(nproc --all)
