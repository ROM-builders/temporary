# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/DerpFest-11/manifest.git -b 11 -g default,-mips,-darwin,-notdefault
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
# DT/VT/KT/TC
git clone --depth=1 https://github.com/darknius20/device_xiaomi_juice --single-branch -b aicp12.1 device/xiaomi/juice
git clone --depth=1 https://github.com/darknius20/android_vendor_xiaomi_juice --single-branch -b 11.0 vendor/xiaomi/juice
git clone --depth=1 https://github.com/darknius20/kernel_poco_citrus --single-branch -b main kernel/xiaomi/juice

# build rom
source build/envsetup.sh
lunch aicp_juice-userdebug
export ALLOW_MISSING_DEPENDENCIES=true
export BUILD_BROKEN_USES_BUILD_COPY_HEADERS=true
export BUILD_BROKEN_DUP_RULES=true
export TZ=Asia/Jakarta #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
