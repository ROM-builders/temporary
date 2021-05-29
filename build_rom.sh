#!/bin/bash

df -h 

## sync rom
repo init -u https://github.com/Project-Fluid/manifest.git --depth=1 -b fluid-11 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/adrian-8901/local_mainfest.git --depth=1 -b fluid .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
ls 
echo finished sync
. build/envsetup.sh
lunch fluid_umi-user 
export ALLOW_MISSING_DEPENDENCIES=true
mka bacon -j$(nproc --all)



rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
