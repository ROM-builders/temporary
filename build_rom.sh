# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/ArrowOS/android_manifest -b arrow-12.0 -g default,-mips,-darwin,-notdefault
git clone  https://github.com/kazu-poi/local_manifest.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch arrow_lava-userdebug
export TZ=Asia/Tokyo #put before last build command
m bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
clone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P


