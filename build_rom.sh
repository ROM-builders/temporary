# Copyright (c) 2021, The Linux Foundation. All rights reserved.
# Thankz to @Apon77

# Date 10-Nov-2021 09:53
# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/AospExtended/manifest.git -b 11.x -g default,-mips,-darwin,-notdefault
git clone https://github.com/AnGgIt86/local_manifest.git --depth=1 -b Aex-11 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
. build/envsetup.sh
lunch aosp_rosy-userdebug
export TZ=Asia/Jakarta
export ALLOW_MISSING_DEPENDENCIES=true
m aex

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
