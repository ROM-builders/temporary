# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/LineageOS/android.git -b lineage-20.0 -g default,-mips,-darwin,-notdefault
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
git clone https://github.com/LineageOS/android_device_xiaomi_whyred.git device/xiaomi/whyred/ -b lineage-20
git clone https://github.com/Darkstar085/device_xiaomi_whyred-common device/xiaomi/sdm660-common/ --depth=1
git clone https://github.com/Darkstar085/vendor_xiaomi_whyred-common.git vendor/xiaomi/sdm660-common/ --depth=1 
git clone https://github.com/Darkstar085/vendor_xiaomi_whyred vendor/xiaomi/whyred --depth=1
# build rom
source build/envsetup.sh
breakfast whyred
export TZ=Asia/Kolkata #put before last build command
brunch whyred

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
