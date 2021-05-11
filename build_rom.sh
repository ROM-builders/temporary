#!/bin/bash

set -exv

# build rom
. build/envsetup.sh
lunch aosp_RMX1941-userdebug
mka bacon -j$(nproc --all)
