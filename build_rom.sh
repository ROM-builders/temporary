# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/ArrowOS/android_manifest.git -b arrow-11.0 -g default,-mips,-darwin,-notdefault
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
git clone https://github.com/Adi-sdm/device_realme_RMX1941 device/realme/RMX1941 && git clone https://github.com/Adi-sdm/android_vendor_realme_RMX1941 -b eleven vendor/realme/RMX1941
wget https://github.com/Realme-C2/patches/raw/main/mt6765.sh && chmod +x mt6765.sh && ./mt6765.sh
# build rom
source build/envsetup.sh
lunch arrow_RMX1941-userdebug
export TZ=Asia/Dhaka #put before last build command
m bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
