## sync rom

repo init --depth=1 --no-repo-verify -u git://github.com/Project-Awaken/android_manifest -b 12 default,-mips,-darwin,-notdefault
git clone https://github.com/IshanDeyA12/local_manifest.git --depth 1 -b awaken .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch cherish_alioth-userdebug
export TZ=Asia/Dhaka
export BUILD_USERNAME=alioth
export BUILD_HOSTNAME=userdebug
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
