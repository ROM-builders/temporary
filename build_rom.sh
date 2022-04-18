# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/PixelPlusUI-Elle/manifest -b eleven -g default,-mips,-darwin,-notdefault
git clone https://github.com/vn-ncvinh/local_manifest_flashlmdd.git --depth 1 -b aosp .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch aosp_flashlmdd-userdebug
export WITH_GAPPS=true
export TARGET_GAPPS_ARCH=arm64
export TZ=Asia/Ho_Chi_Minh #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
