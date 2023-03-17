repo init --depth=1 --no-repo-verify -u https://github.com/P-404/android_manifest -b tokui -g default,-mips,-darwin,-notdefault
git clone https://github.com/karthik1896/local_manifest --depth=1 -b master .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
. build/envsetup.sh
export KBUILD_BUILD_USER=karthik
export KBUILD_BUILD_HOST=karthik
export BUILD_USERNAME=karthik
export BUILD_HOSTNAME=karthik
export TZ=Asia/Delhi ##put before last build command
lunch p404_X00T-userdebug
make bacon -j8

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
