# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/ResurrectionRemix/platform_manifest -b Q -g default,-mips,-darwin,-notdefault
git clone https://github.com/mdsumon2001/local_manifest.git --depth 1 -b rrOS-10 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch rr_RMX2185-userdebug
export ALLOW_MISSING_DEPENDENCIES=true
export BUILD_USER=rm
export BUILD_USERNAME=sumon
export KBUILD_BUILD_USER=sumon
export TZ=Asia/Dhaka #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
