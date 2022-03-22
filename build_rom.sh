# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/CalyxOS/platform_manifest.git -b android10 -g default,-mips,-darwin,-notdefault
git clone -b aex https://github.com/SunnyRaj84348/android_device_xiaomi_riva device/xiaomi/riva --depth=1
git clone -b aex https://github.com/SunnyRaj84348/android_kernel_xiaomi_msm8917 kernel/xiaomi/riva --depth=1
git clone -b aex https://github.com/SunnyRaj84348/android_vendor_xiaomi vendor/xiaomi --depth=1
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch calyx_riva-user
m
export TZ=Asia/Jakarta #put before last build command
mka riva

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
