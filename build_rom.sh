#!/bin/bash

set -e
set -x

# sync rom
repo init -u https://github.com/CipherOS/android_manifest.git -b twelve-L
git clone --depth=1 https://github.com/newuserbtw/local_manifest/blob/main/local_manifest.xml -b main .repo/local_manifest
repo sync -c --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune -j$(nproc --all)
# build rom
source build/envsetup.sh
lunch lineage-Mi439-userdebug
export TZ=Asia/Dhaka #put before last build command
mka bacon -j$(nproc --all)

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
#sorry guys
