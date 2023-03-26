#!/bin/bash

# Sync repositories. Clone sources for compilation.
repo init --depth=1 --no-repo-verify -u https://github.com/ArrowOS-MiPa-Edition/android_manifest.git -b arrow-13.0 -g default,-mips,-darwin,-notdefault
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
git clone --depth 1 -b arrow-13 https://github.com/PrathamWasTaken/device_realme_RM6785 device/realme/RM6785

# Compile the ROM. Build using sources.
. build/envsetup.sh
lunch arrow_RM6785-user
export TZ=Asia/Kolkata
export ARROW_GAPPS=true
mka bacon -j"$(nproc --all)"

# Upload the ROM. Make it available for download.
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
