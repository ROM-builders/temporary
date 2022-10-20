# sync rom
repo init --depth=1 -u https://github.com/xdroid-oss/xd_manifest -b thirteen -g default,-mips,-darwin,-notdefault
git clone https://github.com/Stealth1226/local_manifest --depth 1 -b xd .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch xdroid_miatoll-userdebug
make xd


# upload rom
# If you need to upload json/multiple files too then put like this 'rclone copy out/target/product/mido/*.zip cirrus:mido -P  rclone copy out/target/product/mido/*.zip.json cirrus:mido -P'
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P

