#!/bin/bash

set -e
set -x

# sync rom
repo init -u https://github.com/PixelExperience/manifest -b eleven
git clone https://github.com/SparXFusion/android_device_realme_RMX1941.git device/realme/RMX1941
git clone https://github.com/SparXFusion/android_vendor_realme_RMX1941.git vendor/realme/RMX1941
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)

# build
. build/envsetup.sh
lunch aosp_RMX1941-userdebug
mka bacon -j$(nproc --all)

# upload rom
up(){
        curl --upload-file $1 https://transfer.sh/$(basename $1); echo
        # 14 days, 10 GB limit
}

up out/target/product/RMX1941/*.zip
