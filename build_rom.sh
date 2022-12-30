# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/ArrowOS/android_manifest.git -b arrow-13.0 -g default,-mips,-darwin,-notdefault
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
git clone https://github.com/Pzqqt/android_kernel_xiaomi_sm6150-1 -b pure-phoenix --depth=1 kernel/xiaomi/phoenix
git clone https://github.com/SharmagRit/android_vendor_xiaomi_phoenix -b 13 --depth=1 vendor/xiaomi/phoenix
git clone https://github.com/ArrowOS-Devices/android_device_xiaomi_extras device/xiaomi/extras

# build rom
source build/envsetup.sh
lunch arrow_phoenix-userdebug
export TZ=Asia/Shanghai #put before last build command
m bacon

# upload rom(if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
