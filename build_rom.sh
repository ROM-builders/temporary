# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/ArcaneOS/Arcane_manifest.git -b R -g default,-mips,-darwin,-notdefault
# git clone https://github.com/pocox3pro/Local-Manifests.git --depth 1 -b master .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# Add Device Dependencies
git clone https://github.com/felapr1804/android_device_xiaomi_raphael.git -b eleven device/xiaomi/raphael
git clone https://github.com/Evolution-X-Devices/vendor_xiaomi_raphael.git -b elle vendor/xiaomi/raphael
git clone https://github.com/Alchemist-xD/android_kernel_xiaomi_raphael.git kernel/xiaomi/raphael


# build rom
source build/envsetup.sh
lunch aosp_raphael-userdebug
export TZ=Asia/Kolkata #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
