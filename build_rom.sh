# sync rom.  
repo init --depth=1 --no-repo-verify -u https://github.com/exthmui/android.git -b exthm-11 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/mukulsharma06175/frostmanifest --depth 1 -b derp .repo/local_manifests
repo sync -c -f --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune -j8

build rom
. build/envsetup.sh
lunch octavi_lavender-userdebug
brunch lavender


# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
