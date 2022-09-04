# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/ResurrectionRemix/platform_manifest.git -b Q -g default,-mips,-darwin,-notdefault
git clone https://github.com/exynos7580-dev/local_manifests.git --depth 1 -b Q .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
. build/envsetup.sh
lunch rr_j7elte-userdebug
export TZ=Europe/Istanbul #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
