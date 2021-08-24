# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Wave-Project/manifest -b r -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/dlwlrma123/local_manifest-1.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch wave_RMX2020-userdebug
export TZ=Asia/Dhaka #put before last build command
export TARGET_FACE_UNLOCK_SUPPORTED=true
export TARGET_USES_BLUR=true
export SKIP_ABI_CHECKS=true
export SKIP_API_CHECKS=true
brunch RMX2020

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
