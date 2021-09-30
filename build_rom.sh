# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Octavi-OS/platform_manifest.git -b 11 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/atharv2951/local_manifest --depth 1 -b main .repo/local_manifests
repo sync -c -f --force-sync --optimized-fetch --no-tags --no-clone-bundle --prune -j8

# build rom
. build/envsetup.sh
lunch octavi_pine-userdebug
export TZ=Asia/Dhaka #put before last build command
brunch pine

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
