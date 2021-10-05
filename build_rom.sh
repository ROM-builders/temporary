# sync rom
repo init --depth=1 --no-repo-verify -u https://android.googlesource.com/platform/manifest -b android-12.0.0_r2 -g default,-device,-mips,-darwin,-notdefault
git clone https://GitHub.com/flashokillerify/manifest_pine --depth 1 -b A12 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom...
source build/envsetup.sh
lunch aosp_pine-userdebug
export TZ=Asia/Kolkata #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
