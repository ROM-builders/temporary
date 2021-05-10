#!/bin/bash

set -e
set -x

# build
. build/envsetup.sh
lunch aosp_RMX1941-userdebug
chmod -R 755 out/
mka bacon -j$(nproc --all)

