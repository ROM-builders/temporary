# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/PixysOS/manifest -b twelve -g default,-mips,-darwin,-notdefault
git clone https://github.com/j0ok34n/local_manifests.git --depth 1 -b pixys .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
. build/envsetup.sh
lunch pixys_flashlmdd-userdebug
export TZ=Asia/Ho_Chi_Minh
make pixys

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
