# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/dotOS/manifest.git -b dot11 -g default,-device,-mips,-darwin,-notdefault
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
git clone https://github.com/muhammad23012009/android_device_motorola_hannah -b lineage-18.1 device/motorola/hannah
git clone https://github.com/LineageOS/android_device_motorola_hannah-common -b lineage-18.1 device/motorola/hannah-common
git clone https://github.com/lineageos/android_device_motorola_msm8937-common -b lineage-18.1 device/motorola/msm8937-common
git clone https://github.com/lineageOS/android_kernel_motorola_msm8953 -b lineage-18.1 kernel/motorola/msm8953
git clone https://github.com/themuppets/proprietary_vendor_motorola vendor/motorola

# build rom
source build/envsetup.sh
lunch dot_hannah-userdebug
export TZ=Asia/Dhaka #put before last build command
m bacon -j24

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
