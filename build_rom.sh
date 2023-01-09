# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/xdroid-oss/xd_manifest -b 11 -g default,-mips,-darwin,-notdefault
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
rm -rf hardware/qcom-caf/sdm660/audio
git clone https://github.com/Travelerext/android_device_xiaomi_clover.git -b thirteen
git clone https://github.com/pix106/android_hardware_qcom-caf_audio.git hardware/qcom-caf/sdm660/audio
git clone https://github.com/sabarop/android_vendor_xiaomi_clover.git -b 20-clover+ vendor/xiaomi/clover
git clone https://github.com/pix106/android_kernel_xiaomi_southwest-4.19.git -b main kernel/xiaomi/sdm660


# build rom
source build/envsetup.sh
lunch xdroid_clover-userdebug
export TZ=Asia/Dhaka #put before last build command
make xd -j$(nproc --all)

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
