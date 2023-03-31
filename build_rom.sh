#!/bin/bash

# Synchronize the sources.
repo init --depth=1 --no-repo-verify -u https://github.com/PixelOS-AOSP/manifest.git -b thirteen -g default,-mips,-darwin,-notdefault
git clone https://github.com/PrathamWasTaken/local_manifests.git --depth 1 -b pixel-thirteen .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# Build the rom.
. build/envsetup.sh
lunch aosp_RM6785-user
export TZ=Asia/Kolkata #put before last build command
m bacon

# Upload the rom.
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
