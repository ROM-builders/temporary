# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/StatiXOS/android_manifest.git -b sc  -g default,-mips,-darwin,-notdefault
git clone https://github.com/Fr0ztyy43/begonia-nowy/blob/main/lcoal_manifest --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh

export TZ=Asia/Dhaka #put before last build command
brunch statix_begonia-userdebug
# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
