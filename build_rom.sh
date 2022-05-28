# sync rom
repo init -u https://github.com/ProjectBlaze/manifest.git -b 12.1
git clone https://github.com/j0ok34n/local_manifests.git --depth 1 -b blaze .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j4

# build rom
export WITH_GAPPS=true
export TARGET_GAPPS_ARCH=arm64
export TZ=Asia/Ho_Chi_Minh
source build/envsetup.sh
lunch blaze_flashlmdd-userdebug
make bacon


# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
