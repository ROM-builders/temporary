# sync rom
repo init --depth=1 -u git://github.com/DotOS/manifest.git -b dot11 -g default,-device,-mips,-darwin,-notdefault
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# gitclone all needed
git clone https://github.com/Orangeskai/android_device_realme_RMX2001 -b DotOs --depth=1 device/realme/RMX2001
git clone https://github.com/Orangeskai/android_kernel_realme_RMX2001 -b DotOs --depth=1 kernel/realme/RMX2001
git clone https://github.com/Orangeskai/proprietary_vendor_realme -b Dotos --depth=1 vendor/realme
git clone https://github.com/Orangeskai/android_device_realme_mt6785-common -b lineage-18.1-plus --depth=1 device/realme/mt6785-common

# build rom
source build/envsetup.sh
lunch dot_RMX2001-userdebug
export TZ=Asia/Jakarta #put before last build command
make bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
