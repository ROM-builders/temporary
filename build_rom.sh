# sync rom
repo init --depth=1 --no-repo-verify https://github.com/CherishOS/android_manifest.git -b tiramisu -g default,-mips,-darwin,-notdefault
git clone https://github.com/ShahzebQureshi/local_manifest --depth 1 -b cherish .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
export BUILD_USER=ShahzebQureshi
export BUILD_HOST=cirrus-ci
export BUILD_USERNAME=ShahzebQureshi
export BUILD_HOSTNAME=cirrus-ci
lunch cherish_joan-userdebug
export TZ=Asia/Karachi #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
