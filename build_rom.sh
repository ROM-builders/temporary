# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/crdroidandroid/android.git -b 12.1 -g default,-mips,-darwin,-notdefault
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

git clone https://github.com/realme-mt6771-devs/android_device_oppo_CPH1859 device/oppo/CPH1859
git clone https://github.com/realme-mt6771-devs/android_device_realme_mt6771-common device/realme/mt6771-common
git clone https://github.com/realme-mt6771-devs/android_kernel_realme_mt6771 kernel/realme/mt6771
git clone https://github.com/realme-mt6771-devs/android_vendor_oppo_CPH1859 vendor/oppo/CPH1859
rm -rf device/mediatek/sepolicy_vndr
git clone https://github.com/CorvusRom-Devices/device_mediatek_sepolicy_vndr device/mediatek/sepolicy_vndr

# build rom
source build/envsetup.sh
lunch lineage_CPH1859-userdebug
export TZ=Asia/Kolkata #put before last build command
mka bacon


# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
