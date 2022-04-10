# sync rom
repo init --depth=1 -u git://github.com/AospExtended/manifest.git -b 12.x
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
git clone https://github.com/anht3889/android_device_lge_sm8150-common -b aosp device/lge/sm8150-common
git clone https://github.com/anht3889/android_device_lge_flash-common -b aosp device/lge/flash-common
git clone https://github.com/anht3889/android_device_lge_flashlmdd -b aosp device/lge/flashlmdd
git clone https://github.com/anht3889/android_device_lge_common -b aosp device/lge/common
git clone https://github.com/anht3889/proprietary_vendor_lge -b aosp vendor/lge
git clone https://github.com/anht3889/android_kernel_lge_sm8150_new -b aosp kernel/lge/sm8150
git clone https://github.com/anht3889/android_hardware_lge -b aosp hardware/lge

# build rom
source build/envsetup.sh
lunch aosp_flashlmdd-userdebug
m aex -j$(nproc --all)

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
