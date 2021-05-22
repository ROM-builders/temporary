# sync rom
repo init --depth=1 -u git://github.com/ShapeShiftOS/manifest.git -b android_11 -g default,-device,-mips,-darwin,-notdefault
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

git clone https://github.com/ShapeShiftOS-Devices/device_xiaomi_violet device/xiaomi/violet --depth 1
git clone https://github.com/ShapeShiftOS-Devices/kernel_xiaomi_violet kernel/xiaomi/violet --depth 1
git clone https://github.com/ShapeShiftOS-Devices/vendor_xiaomi_violet vendor/xiaomi/violet --depth 1

# build rom
source build/envsetup.sh
lunch ssos_violet-userdebug
brunch violet

# upload rom
# If you need to upload json/multiple files too then put like this 'rclone copy out/target/product/mido/*.zip cirrus:mido -P && rclone copy out/target/product/mido/*.zip.json cirrus:mido -P'
rclone copy out/target/product/violet/*.zip cirrus:mido -P
