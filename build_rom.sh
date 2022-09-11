# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/ArrowOS/android_manifest.git -b arrow-13.0 -g default,-mips,-darwin,-notdefault
git clone https://github.com/UdayBindal2312/local_manifest.git -b arrow --depth 1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom#
source build/envsetup.sh
lunch arrow_miatoll-userdebug
export TZ=Asia/Kolkata # Add before last build command
mka miatoll
# upload rom
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
