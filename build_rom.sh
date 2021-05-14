#!/bin/bash

set -e
set -x


# sync rom

repo init -u https://github.com/PixelExperience/manifest -b eleven --depth=1 -g default,-device,-mips,-darwin,-notdefault

git clone https://github.com/cArN4gEisDeD/local_manifest --depth=1 -b main .repo/local_manifests

repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all) || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8


# build
. build/envsetup.sh
lunch aosp_RMX1941-userdebug
mka bacon

# upload
rclone copy out/target/product/RMX1941/*UNOFFICIAL*.zip cirrus:RMX1941 -P
