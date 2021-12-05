# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/ShapeShiftOS/android_manifest.git -b android_11 -g default,-mips,-darwin,-notdefault
git clone https://github.com/Kendras056/local_manifests.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all) 

# build rom
source build/envsetup.sh
lunch ssos_X00TD-userdebug
export SKIP_API_CHECKS=true
export ALLOW_MISSING_DEPENDENCIES=true
export BUILD_USERNAME=tiktodz
export BUILD_HOSTNAME=android-build
export TZ=Asia/Tokyo
make bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
