# sync rom
repo init -u https://github.com/EternityOS-Plus-Tiramisu/manifest -b 13 -g default,-mips,-darwin,-notdefault
git clone https://github.com/agathasenpai/local_manifest
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

# build rom
. build/envsetup.sh
lunch aosp_ginkgo-userdebug
export KBUILD_BUILD_USER=agathasenpai
export KBUILD_BUILD_HOST=cirrus-ci
export BUILD_USERNAME=agathasenpai
export BUILD_HOSTNAME=cirrus-ci
export TZ=Asia/Jakarta #put before last build command
mka bacon -j

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
