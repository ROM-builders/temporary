# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/xdroid-oss/xd_manifest -b twelve -g default,-mips,-darwin,-notdefault
git clone https://github.com/WallBreaker2407/local_manifest.git --depth 1 -b xdroid .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch xdroid_X00TD-userdebug
export TZ=Asia/Jakarta #put before last build command
export BUILD_USERNAME=GeForce-RTX
export BUILD_HOSTNAME=android_build
export SELINUX_IGNORE_NEVERALLOWS := true
make xd

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
