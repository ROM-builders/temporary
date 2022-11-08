# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/CherishOS/android_manifest.git -b tiramisu -g default,-mips,-darwin,-notdefault
git clone https://github.com/Prvtcmt/lcl_mnfst.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
. build/envsetup.sh
lunch cherish_mido-userdebug
export KBUILD_BUILD_USER=Rsyd
export KBUILD_BUILD_HOST=Enka
export BUILD_HOSTNAME=Enka
export BUILD_USERNAME=Rsyd
export CHERISH_VANILLA=true
export PRODUCT_BROKEN_VERIFY_USES_LIBRARIES=true
export TZ=Asia/Jakarta
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P

