# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/PixelExperience/manifest -b twelve-plus -g default,-mips,-darwin,-notdefault
git clone https://github.com/mika1zumi/local_manifest.git --depth 1 -b EvoX-Snow .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch aosp_X00TD-userdebug
export TARGET_GAPPS_ARCH := arm64
export TARGET_USES_MINI_GAPPS := true
export TARGET_INCLUDE_STOCK_ARCORE := false
export TARGET_INCLUDE_LIVE_WALLPAPERS := false
export TARGET_SUPPORTS_GOOGLE_RECORDER := false
export TARGET_SUPPORTS_QUICK_TAP := true
export TZ=Asia/Jakarta #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
