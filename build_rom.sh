# sync rom
repo init -u https://github.com/ArrowOS/android_manifest.git -b arrow-11.0 -g default,-mips,-darwin,-notdefault
git clone https://github.com/briant24/local_manifest.git --depth 1 -b master .repo/local_manifest
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch arrow_kenzo-userdebug
export TZ=Asia/Dhaka #put before last build command
export BUILD_USERNAME=briant24
export BUILD_HOSTNAME=CirrusCi
m bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
