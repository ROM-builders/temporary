# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/ResurrectionRemix/platform_manifest.git -b Q -g default,-device,-mips,-darwin,-notdefault

git clone https://github.com/MrPurple666/local_manifest.git --depth=1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
make clean
lunch rr_tulip-userdebug
export TZ=America/Brazil #put before last build command
export TARGET_KERNEL_CONFIG=mystic-tulip-oldcam_defconfig
export TARGET_KERNEL_SOURCE=kernel/xiaomi/sdm660
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
