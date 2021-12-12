# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/bluecrossdev/manifest -b 12.x -g default,-mips,-darwin,-notdefault
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# Clone device source
git clone https://github.com/bluecrossdev/device_google_crosshatch -b 12.x device/google/crosshatch
git clone https://github.com/bluecrossdev/device_google_crosshatch-sepolicy device/google/crosshatch-sepolicy
git clone https://github.com/bluecrossdev/vendor_google vendor/gpx --depth=1
mkdir vendor/google
mv vendor/gpx/* vendor/google/
git clone https://github.com/HotDogfinba11/kernel_google_msm-4.9 --depth=1 kernel/google/bluecross
rm -rf device/aosp/sepolicy
git clone https://github.com/herobuxx/device_custom_sepolicy device/aosp/sepolicy
git clone https://github.com/ProtonAOSP/android_packages_apps_ElmyraService packages/apps/ElmyraService -b sc

# Set timezone
export TZ=Asia/Jakarta

# Extra build flags
export WITH_GAPPS=true

# Build for Pixel 3
source build/envsetup.sh
lunch aosp_blueline-user
mka aex

# Upload for Pixel 3
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P

# Build for Pixel 3 XL
source build/envsetup.sh
lunch aosp_crosshatch-user
mka aex

# Upload for Pixel 3 XL
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
