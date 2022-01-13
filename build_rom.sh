# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/LessAosp/manifest -b twelve -g default,-mips,-darwin,-notdefault
git clone  --depth 1 https://github.com/NouBoi/local_manifests -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch aosp_pine-userdebug
export TARGET_GAPPS_ARCH=arm64
export TZ=Asia/Kolkata #put before last build command
export ALLOW_MISSING_DEPENDENCIES=true
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
export SELINUX_IGNORE_NEVERALLOWS=true

# Build
maka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
