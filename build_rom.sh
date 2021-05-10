#!/bin/bash

# sync rom
repo init --depth=1 -u git://github.com/crdroidandroid/android.git -b 11.0 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/boedhack/local_manifest.git --depth 1 -b 11.0 .repo/local_manifests --depth=1
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)

# build rom
source build/envsetup.sh
lunch lineage_mojito-userdebug
mka bacon

# upload rom
time rclone copy out/target/product/mojito/*Unofficial-test.zip cirrus:mojito -P
