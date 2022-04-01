# sync rom
repo init --depth=1 -u https://github.com/ProtonAOSP-SDMxx0/android_manifest -b sc-v2 -g default,-mips,-darwin,-notdefault
git clone https://github.com/ProtonAOSP-SDMxx0/local_manifest --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch X01BD-userdebug
export TZ=Asia/Jakarta #put before last build command
make otapackage

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
