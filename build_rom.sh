# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Spark-Rom/manifest -b spark -g default,-mips,-darwin,-notdefault
git clone https://github.com/mika1zumi/local_manifest --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch spark_X00TD-userdebug
export TARGET_FACE_UNLOCK_SUPPORTED := true
export TARGET_SUPPORTS_QUICK_TAP := true
export TZ=Asia/Tokyo #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
