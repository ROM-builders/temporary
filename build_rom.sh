# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/exthmui/android.git -b exthm-11 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/N4veenNK/local_manifest.git --depth=1 -b exthmui .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
. build/envsetup.sh
lunch exthm_X00T-userdebug
export TARGET_GAPPS_ARCH=arm64
export TZ=Asia/Kolkata #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
