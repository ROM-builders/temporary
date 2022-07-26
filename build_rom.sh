# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/SuperiorOS/manifest.git -b twelvedotone -g default,-mips,-darwin,-notdefault
git clone https://github.com/progcker/local_manifest.git --depth 1 -b superior-twelveL .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch superior_CPH1859-userdebug
export SELINUX_IGNORE_NEVERALLOWS=true
export ALLOW_MISSING_DEPENDENCIES=true
#export BUILD_WITH_GAPPS=true
#export TARGET_SUPPORTS_NEXT_GEN_ASSISTANT=true
#export TARGET_SUPPORTS_GOOGLE_RECORDER=true
export TZ=Asia/Kolkata #put before last build command
m bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
