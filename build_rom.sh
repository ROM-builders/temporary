#!/bin/bash

# sync rom
repo init -u git://github.com/PixelPlusUI/manifest.git --depth=1 -b eleven -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/boedhack/local_manifest.git -b 11.0 --depth 1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)

# build rom
. build/envsetup.sh
lunch aosp_mojito-userdebug
mka bacon

# upload rom
time rclone copy out/target/product/mojito/*.zip cirrus:mojito -P
