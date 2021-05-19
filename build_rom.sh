#!/bin/bash

set -exv

# sync rom
repo init -u https://github.com/Project-Fluid/manifest.git --depth=1 -b fluid-11 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/adrian-8901/local_mainfest.git --depth=1 -b fluid .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
echo finished sync


# build rom
source build/envsetup.sh
lunch fluid_umi-userdebug
mka bacon -j$(nproc -all)


rclone copy out/target/product/umi/*.zip cirrus:umi -P






