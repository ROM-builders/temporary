#!/bin/bash
# sync rom
repo init --depth=1 -u git://github.com/CherishOS/android_manifest.git -b eleven 
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)

# Clone TREE
git clone https://github.com/linuxmobile/android_device_xiaomi_chiron-common -b cherish-11 device/xiaomi/msm8998-common
git clone https://github.com/linuxmobile/android_device_xiaomi_chiron -b cherish-11 device/xiaomi/chiron
git clone https://github.com/linuxmobile/vendor-xiaomi -b cherish-11 vendor/xiaomi
git clone https://github.com/linuxmobile/android_kernel_xiaomi_msm8998 -b cherish-11 kernel/xiaomi/msm8998

# build rom
source build/envsetup.sh
lunch cherish_chiron-userdebug
make bacon -j$(nproc --all)

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
