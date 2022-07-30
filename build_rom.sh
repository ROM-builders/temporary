# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Corvus-R/android_manifest.git -b 12-test -g default,-mips,-darwin,-notdefault
git clone --depth=1 https://github.com/donboruza/device_redmi_note8pro -b corvus device/redmi/begonia
git clone --depth=1 https://github.com/donboruza/vendor_redmi_note8pro -b twelve vendor/redmi/begonia
git clone --depth=1 https://github.com/donboruza/android_kernel_xiaomi_mt6785 -b 12.1 kernel/xiaomi/mt6785
git clone --depth=1 https://github.com/donboruza/android_device_mediatek_sepolicy -b 12.1 device/mediatek/sepolicy
git clone --depth=1 https://github.com/donboruza/android_vendor_redmi_begonia-ims -b 12.0 vendor/redmi/begonia-ims
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build roms
. build/envsetup.sh
lunch corvus_begonia-userdebug
lunch corvus_begonia-userdebug
export TZ=Asia/Jakarta
make corvus

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
