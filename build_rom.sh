# sync rom
repo init -u https://github.com/xdroid-CAF/xd_manifest -b eleven --no-repo-verify -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/Hotorou/local.git --depth 1 -b xdroid .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch xdroid_daisy-userdebug
export TZ=Asia/Dhaka #put before last build command
make xd -j18

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
