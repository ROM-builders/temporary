#!/bin/bash

set -exv

# sync rom
repo init -u https://github.com/Project-Fluid/manifest.git --depth=1 -b fluid-11
git clone https://github.com/adrian-8901/local_mainfest.git --depth=1 -b fluid .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
echo finished sync


# build rom
source build/envsetup.sh
lunch fluid_umi-userdebug
mka bacon -j64


# upload rom
time rclone copy out/target/product/umi/*.zip cirrus:Umi -P

# 1 2 3 4 5




