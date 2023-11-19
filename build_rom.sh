# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/alphadroid-project/manifest -b alpha-13 -g default,-mips,-darwin,-notdefault
git clone https://github.com/rushiranpise/local_manifest --depth 1 -b crdroid .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch lineage_chef-userdebug
export TARGET_HAS_UDFPS=false
export TARGET_ENABLE_BLUR=true
export TARGET_EXCLUDES_AUDIOFX=true
export TARGET_FACE_UNLOCK_SUPPORTED=true
# export WITH_GAPPS=false
# export TARGET_INCLUDE_GOOGLE_TELEPHONY=false
# export TARGET_INCLUDE_PIXEL_FRAMEWORK=false
# export TARGET_INCLUDE_GOOGLE_CAMERA=false
# export TARGET_SUPPORTS_GOOGLE_RECORDER=false
export TARGET_SUPPORTS_QUICK_TAP=true
# export TARGET_INCLUDE_GMAIL=false
# export TARGET_INCLUDE_GOOGLE_MAPS=false
export TARGET_INCLUDE_MATLOG=false
export TARGET_DEFAULT_ADB_ENABLED=true
export ALPHA_BUILD_TYPE=Official
export ALPHA_MAINTAINER=rushiranpise
export TZ=Asia/Dhaka #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
#12
