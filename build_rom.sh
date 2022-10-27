# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/darknius09/platform_manifest.git -b Q -g default,-mips,-darwin,-notdefault
git clone https://github.com/ZualoliconVN/local_manifest.git --depth 1 -b rr .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
export SELINUX_IGNORE_NEVERALLOWS=true
export KBUILD_BUILD_USER=ZualoliconVN
export KBUILD_BUILD_HOST=ZualoliconVN
export BUILD_USERNAME=ZualoliconVN
export BUILD_HOSTNAME=ZualoliconVN
export RELAX_USES_LIBRARY_CHECK=true
export SKIP_ABI_CHECKS=true
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
export USE_DEXOPT=true
export TZ=Asia/Kolkata #put before last build command
lunch rr_griffin-userdebug
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
