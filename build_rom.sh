#!/bin/bash

set -e
set -x


# sync rom

repo init -u git://github.com/LineageOS/android.git -b lineage-17.1 --depth=1 -g default,-device,-mips,-darwin,-notdefault

git clone https://github.com/baibhab34/local_manifest --depth=1 -b los .repo/local_manifests

repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all) || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8


# build
. build/envsetup.sh
lunch lineage_RMX1805-userdebug
mka bacon

# upload
rclone copy out/target/product/RMX1805/lineage*.zip cirrus:RMX1805 -P
