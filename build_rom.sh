# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Swamoy14/android_manifest.git -b PR10 11 -g default,-mips,-darwin,-notdefault
git clone https://github.com/Dhanzu28/local_manifest.git --depth 1 -b PR10 .repo/local_manifests
repo sync -j$( nproc --all ) --force-sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
breakfast X00TD
export BUILD_USERNAME=mikaaaa29
export BUILD_HOSTNAME=android_build
export TZ=Asia/Bangkok #put before last build command
brunch X00TD

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
