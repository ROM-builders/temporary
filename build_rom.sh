# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/LineageOS/android.git -b lineage-18.1 -g default,-device,-mips,-darwin,-notdefault
git clone -b lineage-18.1 https://github.com/mi-sdm439/android_device_xiaomi_pine device/xiaomi/pine --depth=1
git clone -b a11/clean https://github.com/vytska69/android_kernel_xiaomi_sdm439 kernel/xiaomi/sdm439 --depth=1
git clone -b lineage-18.1 https://github.com/mi-sdm439/android_device_xiaomi_sdm439-common device/xiaomi/sdm439-common --depth=1
git clone -b lineage-18.1 https://github.com/mi-sdm439/proprietary_vendor_xiaomi_pine vendor/xiaomi/pine --depth=1
git clone -b lineage-18.1 https://github.com/mi-sdm439/proprietary_vendor_xiaomi_sdm439-common vendor/xiaomi/sdm439-common --depth=1
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch lineage_pine-userdebug
export TZ=Asia/Dhaka #put before last build command
mka derp

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
