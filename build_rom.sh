# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/AOSPA/manifest -b topaz -g default,-mips,-darwin,-notdefault
git clone https://github.com/Miiyo/local-manifest.git --depth 1 -b aospa-topaz .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build roms
lunch aospa_akari-userdebug
export BUILD_USERNAME=nobody
export BUILD_HOSTNAME=android-build
export KBUILD_BUILD_USER=nobody
export KBUILD_BUILD_HOST=android-build
export TZ=Asia/Singapore
./rom-build.sh akari -c -t userdebug -v beta

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P

