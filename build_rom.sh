#!/bin/bash

# sync rom
repo init -u git://github.com/crdroidandroid/android.git --depth=1 -b 11.0 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/boedhack/local_manifest.git -b 11.0 --depth 1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)

# build rom
. build/envsetup.sh
lunch lineage_mojito-userdebug
export SKIP_API_CHECKS=true
export SKIP_ABI_CHECKS=true
mka bacon

# upload rom
time rclone copy out/target/product/mojito/*.zip cirrus:mojito -P
