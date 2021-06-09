# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/LineageOS/android.git -b lineage-18.1 -g default,-device,-mips,-darwin,-notdefault
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
git clone https://github.com/TasinAyon/device_xiaomi_sdm660-common --depth=1 -b dumaloo-release device/xiaomi/sdm660-common
git clone https://github.com/TasinAyon/kernel_xiaomi_lavender --depth=1 -b dumaloo-release kernel/xiaomi/lavender
git clone https://github.com/TasinAyon/vendor_xiaomi_lavender --depth=1 -b dumaloo-release vendor/xiaomi/lavender
git clone https://github.com/TasinAyon/vendor_xiaomi_sdm660-common --depth=1 -b dumaloo-release vendor/xiaomi/sdm660-common
git clone https://github.com/TasinAyon/device_xiaomi_lavender-1 --depth=1 -b dumaloo-release device/xiaomi/lavender
git clone https://github.com/TasinAyon/android_device_qcom_sepolicy --depth=1 -b lineage-18.1-legacy-um device/qcom/sepolicy-legacy-um

# build rom
source build/envsetup.sh
lunch lineage_lavender-userdebug
export TZ=Asia/Dhaka #put before last build command
WITHOUT_CHECK_API=make bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
